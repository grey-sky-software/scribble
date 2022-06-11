# build stage
FROM ruby:2.7.5-alpine AS build-env
ADD . /dist
RUN apk add --update --no-cache \
  curl \
  gcc \
  g++ \
  libmagic \
  lzip \
  make \
  npm \
  postgresql-dev


RUN apk add --update --no-cache --wait 10 \
  libstdc++ \
  libx11 \
  libxrender \
  libxext \
  libssl1.1


RUN cd /dist && bundle install

# final stage
FROM alpine
WORKDIR /dist
COPY --from=build-env /dist .
CMD bundle exec hanami server
