FROM ruby:2.6.6-stretch

RUN apt-get update

ENV BUNDLE_GEMFILE=/tmp/Gemfile BUNDLE_GEMFILE_LOCK=/tmp/Gemfile.lock BUNDLE_JOBS=4 BUNDLE_PATH=/bundle
ENV APP /app

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler -v "$(grep -A 1 'BUNDLED WITH' ${BUNDLE_GEMFILE_LOCK} | tail -n 1)"
RUN bundle install

RUN mkdir $APP
WORKDIR $APP
ADD . $APP

