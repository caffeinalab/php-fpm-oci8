FROM php:fpm-alpine
LABEL maintainer "Stefano Azzolini <stefano.azzolini@caffeina.com>"

VOLUME /etc/tnsnames.ora

ADD oracle /tmp/oracle

RUN unzip /tmp/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
 unzip /tmp/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
 unzip /tmp/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \
 ln -s /usr/local/instantclient/lib* /usr/lib && \
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
 rm -rf /tmp/oracle

RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient
RUN docker-php-ext-install oci8
