FROM php:7.1-fpm-alpine

LABEL maintainer "Stefano Azzolini <stefano.azzolini@caffeina.com>"

RUN apk update && cd /var/www/html && \
 curl -O# https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip && \
 unzip instantclient-basic-linux.x64-12.2.0.1.0 -d /usr/local && \ 
 curl -O# https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip && \ 
 unzip instantclient-sdk-linux.x64-12.2.0.1.0 -d /usr/local && \ 
 curl -O# https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip && \ 
 unzip instantclient-sqlplus-linux.x64-12.2.0.1.0 -d /usr/local && \ 
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \ 
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \ 
 ln -s /usr/local/instantclient/lib* /usr/lib && \ 
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \ 
 docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \ 
 docker-php-ext-install oci8 && \ 
 rm -rf /var/lib/apt/lists/* && \ 
 php -v

VOLUME /etc/tnsnames.ora


