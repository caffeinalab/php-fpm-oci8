FROM php:fpm
LABEL maintainer "Stefano Azzolini <stefano.azzolini@caffeina.com>"

RUN apt-get update && apt-get -y install wget bsdtar libaio1 && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip | bsdtar -xvf-  -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \
 ln -s /usr/local/instantclient/lib* /usr/lib && \
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
 docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \
 docker-php-ext-install oci8 && \
 rm -rf /var/lib/apt/lists/* && \
 php -v

RUN	mkdir -p /usr/src/php_oci && \
  cd /usr/src/php_oci && \
  wget http://php.net/distributions/php-$PHP_VERSION.tar.gz && \
  tar xfvz php-$PHP_VERSION.tar.gz && \
  cd php-$PHP_VERSION/ext/pdo_oci && \
  phpize && \
  ./configure --with-pdo-oci=instantclient,/usr/local/instantclient,12.1 && \
  make && \
  make install && \
  echo extension=pdo_oci.so > /usr/local/etc/php/conf.d/pdo_oci.ini && \
  php -v

VOLUME /etc/tnsnames.ora


