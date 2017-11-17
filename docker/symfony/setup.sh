#!/bin/bash
cd /var/www
/usr/local/bin/composer install
/usr/local/bin/composer req cli
/usr/local/bin/composer req admin
mkdir -p /var/www/var/cache
mkdir -p /var/www/var/log
chmod -R 777 /var/www/var/cache
chmod -R 777 /var/www/var/log
cc