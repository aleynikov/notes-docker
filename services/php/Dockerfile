FROM php:7.1-fpm-alpine3.4
RUN apk update --no-cache \
    && apk add --no-cache $PHPIZE_DEPS \
    && apk add --no-cache mysql-dev \
    && docker-php-ext-install mysqli mbstring tokenizer mysqli pdo_mysql

RUN mkdir -p /var/log/php \
    && chown www-data /var/log/php

WORKDIR /app

ADD php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer
