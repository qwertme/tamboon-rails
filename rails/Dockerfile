FROM ruby:2.3.1-alpine

RUN apk add --update postgresql-dev imagemagick git curl-dev ruby-dev build-base tzdata nodejs

RUN apk add --update --no-cache --virtual build-deps build-base make

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle

COPY ./ $APP_HOME

RUN gem install bundler foreman && bundle install

EXPOSE 3000

VOLUME [ $APP_HOME, $APP_HOME/public/uploads ]

RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories && \
    apk add --no-cache yarn

CMD bundle exec foreman start -f Procfile
