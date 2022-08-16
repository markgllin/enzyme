FROM ruby:3.1.2-alpine3.16 as base

EXPOSE 4567

COPY . /app
WORKDIR /app

# build essentials for puma
RUN apk add --update alpine-sdk

RUN bundle
RUN ruby spec/enzyme_test_cases.rb >> results.txt

ENTRYPOINT [ "ruby", "lib/sinatra.rb" ]
