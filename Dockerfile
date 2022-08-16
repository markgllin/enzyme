FROM ruby:3.1.2-alpine3.16 as base

COPY . /app
WORKDIR /app

RUN ruby spec/enzyme_test_cases.rb >> results.txt


FROM nginx
EXPOSE 8080

COPY --from=base /app/results.txt /usr/share/nginx/html/results.txt
