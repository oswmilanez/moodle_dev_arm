#!/bin/bash

#php
/etc/init.d/php8.2-fpm start

#nginx
/usr/sbin/nginx -g 'daemon off;'
