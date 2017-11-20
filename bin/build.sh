#!/bin/bash
. $(dirname "$0")/config.inc

echo 'Creating $appname data volumn(s)'
docker volumn \
    -v "$('pwd')/webapp/public":/var/www/public \
    $appname_vpublic

# Build images
echo 'Building images'
docker build -t $appname_mysql_img -f ./docker/mysql/Dockerfile .
docker build -t $appname_mail_img -f ./docker/mailhog/Dockerfile .
docker build -t $appname_nginx_img -f ./docker/nginx/Dockerfile .
docker build -t $appname_img .

# Run containers
echo 'Building containers'
docker run -d --name=$appname_mail \
 -p 1025:1025 \
 -p 8025:8025 \
 $appname_mail_img

docker run -d -p 3306:3306 --name $appname_mysql $appname_mysql_img

docker run -d -p 9000:9000 --link $appname_mysql:db --link $appname_mail --name $appname \
    -v "$('pwd')/webapp/config":/var/www/config \
    -v "$appname_vpublic":/var/www/public \
    -v "$('pwd')/webapp/src":/var/www/src \
    -v "$('pwd')/webapp/composer.json":/var/www/composer.json \
    -v "$('pwd')/webapp/.env.dist":/var/www/.env \
   $appname_img

docker run -d -p 8080:80 --link $appname:php --name $appname_nginx \
    -v "$('pwd')/webapp/config":/var/www/config \
    -v "$appname_vpublic":/var/www/public \
    -v "$('pwd')/webapp/src":/var/www/src \
    -v "$('pwd')/webapp/composer.json":/var/www/composer.json \
    -v "$('pwd')/webapp/.env.dist":/var/www/.env \
    $appname_nginx_img