#!/bin/bash
cd /var/www
/usr/local/bin/composer install
/usr/local/bin/composer req cli
/usr/local/bin/composer req admin
chmod -R 777 /var/www/var/cache
chmod -R 777 /var/www/var/log
cc