#!/bin/bash

#php
/etc/init.d/php7.4-fpm start

#nginx
/usr/sbin/nginx -g 'daemon off;'
