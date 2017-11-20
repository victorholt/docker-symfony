#!/bin/bash
. $(dirname "$0")/config.inc

docker stop $appname_mysql
docker stop $appname_mail
docker stop $appname_nginx
docker stop $appname