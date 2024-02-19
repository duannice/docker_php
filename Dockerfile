FROM  alpine:3.13
LABEL maintainer="DuanLujian <379167658@qq.com>"
WORKDIR /tmp/
RUN wget https://www.php.net/distributions/php-8.2.16.tar.gz \
        #&& echo http://mirrors.aliyun.com/alpine/v3.13/main/ > /etc/apk/repositories \
        #&& echo http://mirrors.aliyun.com/alpine/v3.13/community/ >> /etc/apk/repositories \
        && apk update \
        && tar zxf php-8.2.16.tar.gz && cd /tmp/php-8.2.16/ \
        && apk add --no-cache  --virtual .build-deps  gcc make g++ \
        && apk add --no-cache tidyhtml-dev  zlib-dev libxml2-dev libzip-dev expat-dev openssl-dev sqlite-dev curl-dev gettext-dev gmp-dev openldap-dev oniguruma-dev net-snmp-dev gdbm-dev libpng-dev libwebp-dev libjpeg-turbo-dev freetype-dev \
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
        --with-tidy \
        --with-wddx \
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
        && cd /tmp/php-8.2.16/ \
        && make && make install \
        && mkdir -p /usr/local/php/etc/ \
        && cp /tmp/php-7.2.16/php.ini-production /usr/local/php/etc/php.ini \
        && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
        && cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf \
        &&  rm -rf /tmp/* \
#删除包
        && apk del .build-deps
EXPOSE 9000
CMD ["/usr/local/php/sbin/php-fpm","-F"]
