#!/bin/bash

appname=symfonyapp
appname_nginx=$appname"_nginx"
appname_mysql=$appname"_mysql"
appname_mail=$appname"_mail"

appname_img=$appname"_img"
appname_nginx_img=$appname_nginx"_img"
appname_mysql_img=$appname_mysql"_img"
appname_mail_img=$appname_mail"_img"

docker stop $appname
docker stop $appname_nginx
docker stop $appname_mysql
docker stop $appname_mail

docker rm $appname
docker rm $appname_mysql
docker rm $appname_nginx
docker rm $appname_mail

docker rmi $appname_img
docker rmi $appname_nginx_img
docker rmi $appname_mysql_img
docker rmi $appname_mail_img