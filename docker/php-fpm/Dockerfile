FROM php:7.4-fpm

RUN apt update \
    && apt install -y apt-utils \
    && apt-get install pkg-config

RUN apt update && apt -y install nano

RUN apt-get install -y libmcrypt-dev openssl \
    && apt-get install -y curl \
    && apt-get -y install zip unzip \
    && apt-get install -y libicu-dev \
    && apt-get install -y libonig-dev

RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo
RUN docker-php-ext-install -j$(nproc) mbstring

RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/doc/*

WORKDIR /var/www/backend

# ovevriding php setting - NOT WORKING (the mount of outside don't work)
# RUN cat docker/php-fpm/php-ini-overrides.ini >> /usr/local/etc/php-fpm.d/www.conf
