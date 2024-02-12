FROM php:7.4.28-fpm-alpine-3.13
RUN docker-php-source extract \ 
    && apk add libjpeg-turbo-dev \
    && apk add libpng-dev \
    && apk add libzip-dev \
    && apk add freetype-dev \
    && apk add php7-opcache \
    && docker-php-ext-install  pdo_mysql \
    && docker-php-ext-install  mysqli \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && apk add autoconf gcc g++ make \
    && pecl install redis-4.0.1 \
    && docker-php-ext-enable redis \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-source delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/pear/download/* 
