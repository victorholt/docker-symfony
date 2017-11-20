#!/bin/bash
. $(dirname "$0")/config.inc

docker stop $appname
docker stop $appname_nginx
docker stop $appname_mysql
docker stop $appname_mail

docker rm $appname
docker rm $appname_nginx
docker rm $appname_mysql
docker rm $appname_mail

docker rmi $appname_img
docker rmi $appname_nginx_img
docker rmi $appname_mysql_img
docker rmi $appname_mail_img

docker volume rm webapp-data