FROM ruby:2.7.5-alpine AS builder

LABEL maintainer="Grey Sky Software <team@greysky.software>"

RUN apk add --no-cache \
  #
  # required
  build-base \
  libffi-dev \
  nodejs \
  tzdata \
  postgresql \
  postgresql-contrib \
  postgresql-dev \
  zlib-dev \
  libxml2-dev \
  libxslt-dev \
  readline-dev \
  bash \
  #
  # Nice to haves
  git \
  vim \
  #
  # Fixes watch file issues with things like HMR
  libnotify-dev

# Install wait-for for docker-compose
RUN wget -O /bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for
RUN chmod +x /bin/wait-for

FROM builder as development

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install any extra dependencies via Aptfile - These are installed on Heroku
# COPY Aptfile /usr/src/app/Aptfile
# RUN apk add --update $(cat /usr/src/app/Aptfile | xargs)

ENV PATH /usr/src/app/bin:$PATH

# Install latest bundler
RUN bundle config --global silence_root_warning 1

EXPOSE 3000
CMD ["bundle", "exec", "hanami", "server", "--host=0.0.0.0", "--port=3000"]

FROM development AS production

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle check || bundle install

# Install NPM Libraries
# COPY package.json /usr/src/app
# RUN npm install

RUN bundle exec rake assets:precompile

# Copy the rest of the app
COPY . /usr/src/app
