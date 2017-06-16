FROM php:fpm-alpine
LABEL maintainer "Stefano Azzolini <stefano.azzolini@caffeina.com>"

RUN curl -o /tmp/basic.zip https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip && \
 curl -o /tmp/sdk.zip https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip && \
 curl -o /tmp/sqlplus.zip https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip && \
 unzip -d /usr/local/ /tmp/basic.zip && \
 unzip -d /usr/local/ /tmp/sdk.zip && \
 unzip -d /usr/local/ /tmp/sqlplus.zip && \
 rm -rf /tmp/*.zip && \
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \
 ln -s /usr/local/instantclient/lib* /usr/lib && \
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
 docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \
 docker-php-ext-install oci8 && \
 rm -rf /var/cache/apk/*

VOLUME /etc/tnsnames.ora
