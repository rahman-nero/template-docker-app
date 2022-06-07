FROM node:16.15.1

# Install supervisor
RUN apt-get update && apt-get install -y supervisor

RUN npm i --location=global laravel-echo-server

WORKDIR /var/www