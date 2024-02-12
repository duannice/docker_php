FROM  alpine:3.13
LABEL maintainer="DuanLujian <379167658@qq.com>"
WORKDIR /tmp/
RUN wget https://www.php.net/distributions/php-7.4.33.tar.gz \
        && tar zxf php-7.4.33.tar.gz && cd /tmp/php-7.4.33/ \
        && apk --update add gcc make g++ zlib-dev libxml2-dev libzip-dev expat-dev openssl-dev sqlite-dev curl-dev gettext-dev gmp-dev openldap-dev oniguruma-dev net-snmp-dev gdbm-dev libpng-dev libwebp-dev libjpeg-turbo-dev freetype-dev \
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
        --with-fpm-user=www \
        --with-fpm-group=www \
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
        --enable-mysqlnd 
        RUN cd /tmp/php-7.4.33/  make && make install
        RUN mkdir -p /usr/local/php/etc/ && cp php.ini-production /usr/local/php/etc/php.ini && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf  &&  rm -rf /tmp/*
EXPOSE 9000
CMD ["/usr/local/php/sbin/php-fpm"]
