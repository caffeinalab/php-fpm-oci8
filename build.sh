#!/bin/bash
docker build -t caffeina/php-fpm-oci8:latest --squash --compress --force-rm -f Dockerfile .  && \
[[ $1 == '--push' ]] && docker push caffeina/php-fpm-oci8:latest