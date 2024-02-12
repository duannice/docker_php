FROM php:7.4.33-fpm-alpine
WORKDIR /var/www
RUN apk add --no-cache autoconf libcurl curl-dev libjpeg jpeg-dev libpng libpng-dev icu-dev libzip libzip-dev shadow freetype freetype-dev libpq postgresql-dev
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data 
RUN docker-php-source extract \ 
        && docker-php-ext-install ctype curl gd intl mysqli pdo pdo_mysql zip exif pdo_pgsql pgsql \
        && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
        && apk add autoconf gcc g++ make \
        && pecl install redis-4.0.1 \
        && docker-php-ext-enable redis \
        && docker-php-ext-enable zip \
        && docker-php-source delete \
        && rm -rf /var/cache/apk/* \
        && rm -rf /tmp/pear/download/*  \
        && rm -rf /tmp/*  \
        && apk del .memcached-deps .phpize-deps
