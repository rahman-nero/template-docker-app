FROM node:16.15.1

# Install supervisor
RUN apk update
RUN apk add supervisor

RUN npm i -g laravel-echo-server

WORKDIR /var/www