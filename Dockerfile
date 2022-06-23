####
# This Dockerfile is used for the development version of Scribble
####

FROM ruby:2.7.5-alpine

LABEL maintainer="Grey Sky Software <team@greysky.software>"

RUN apk add --no-cache \
  bash \
  build-base \
  git \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  postgresql \
  postgresql-contrib \
  postgresql-dev \
  readline-dev \
  tzdata \
  vim \
  zlib-dev \
  #
  # Fixes watch file issues with things like HMR
  libnotify-dev

# Install wait-for for docker-compose
RUN wget -O /bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for
RUN chmod +x /bin/wait-for

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV PATH /usr/src/app/bin:$PATH

# Install latest bundler
RUN bundle config --global silence_root_warning 1

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
COPY .ruby-version /usr/src/app/
RUN bundle check || bundle install

# Install NPM Libraries
# COPY package.json /usr/src/app
# RUN npm install

# Copy the rest of the app
COPY . /usr/src/app

EXPOSE 2300
CMD bundle exec hanami server --host=0.0.0.0 --port=2300
