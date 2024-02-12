FROM  alpine:3.13
LABEL maintainer="DuanLujian <379167658@qq.com>"
WORKDIR /tmp/
RUN wget https://www.php.net/distributions/php-7.4.33.tar.gz \
        && tar zxf php-7.4.33.tar.gz && cd /tmp/php-7.4.33/ \
        && apk add --virtual gcc \
        && apk add --virtual make \
        && apk add --virtual g++ \
        && apk add --virtual zlib-dev \
        && apk add --virtual libxml2-dev \
        && apk add --virtual libzip-dev \
        && apk add --virtual expat-dev \
        && apk add --virtual openssl-dev \
        && apk add --virtual sqlite-dev \
        && apk add --virtual curl-dev \
        && apk add --virtual gettext-dev \
        && apk add --virtual gmp-dev \
        && apk add --virtual openldap-dev \
        && apk add --virtual oniguruma-dev \
        && apk add --virtual net-snmp-dev \
        && apk add --virtual gdbm-dev \
        && apk add --virtual libpng-dev \
        && apk add --virtual libwebp-dev \
        && apk add --virtual libjpeg-turbo-dev \
        && apk add --virtual freetype-dev \
#编译
        && ./configure --prefix=/usr/local/php \
        --with-config-file-path=/usr/local/php/etc/ \
        --with-mysqli \
        --with-pdo-mysql \
        --with-mysql-sock=/usr/local/mysql/mysql.sock \
        --with-iconv-dir \
        --with-freetype \
        --with-jpeg \
        --with-webp \
        --with-curl \
        --with-gdbm \
        --with-gmp \
        --with-zlib \
        --with-xmlrpc \
        --with-openssl \
        --without-pear \
        --with-snmp \
        --with-gettext \
        --with-mhash \
        --with-expat \
        --with-ldap \
        --with-ldap-sasl \
        --with-zip \
        --enable-xml \
        --enable-gd \
        --enable-fpm \
        --enable-ftp \
        --enable-bcmath \
        --enable-soap \
        --enable-shmop \
        --enable-sysvsem \
        --enable-sockets \
        --enable-inline-optimization \
        --enable-maintainer-zts \
        --enable-mbregex \
        --enable-mbstring \
        --enable-pcntl \
        --disable-fileinfo \
        --disable-rpath \
        --enable-opcache \
        --enable-mysqlnd \
        && cd /tmp/php-7.4.33/ \
        && make && make install \
        && mkdir -p /usr/local/php/etc/ \
        && cp /tmp/php-7.4.33/php.ini-production /usr/local/php/etc/php.ini \
        && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
        && cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf \
        &&  rm -rf /tmp/* \
#删除包
        && apk del gcc \
        && apk del make \
        && apk del g++ \
        && apk del zlib-dev \
        && apk del libxml2-dev \
        && apk del libzip-dev \
        && apk del expat-dev \
        && apk del openssl-dev \
        && apk del sqlite-dev \
        && apk del curl-dev \
        && apk del gettext-dev \
        && apk del gmp-dev \
        && apk del openldap-dev \
        && apk del oniguruma-dev \
        && apk del net-snmp-dev \
        && apk del gdbm-dev \
        && apk del libpng-dev \
        && apk del libwebp-dev \
        && apk del libjpeg-turbo-dev\
        && apk del freetype-dev
EXPOSE 9000
CMD ["/usr/local/php/sbin/php-fpm"]
