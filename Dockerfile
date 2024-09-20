FROM ruby:3.1.6
WORKDIR /app
COPY . .
RUN bundle install
