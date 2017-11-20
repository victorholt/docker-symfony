#!/bin/bash
. $(dirname "$0")/config.inc

# Build containers
docker build -t $appname_mysql_img -f ./docker/mysql/Dockerfile .
docker build -t $appname_mail_img -f ./docker/mailhog/Dockerfile .
docker build -t $appname_nginx_img -f ./docker/nginx/Dockerfile .
docker build -t $appname_img .

# Run containers
docker run -d --name=$appname_mail \
 -p 1025:1025 \
 -p 8025:8025 \
 $appname_mail_img

docker run -d -p 3306:3306 --name $appname_mysql $appname_mysql_img

docker run -d -p 9000:9000 --link $appname_mysql:db --link $appname_mail --name $appname $appname_img

docker run -d -p 8080:80 --link $appname:php --name $appname_nginx $appname_nginx_img