#!/bin/bash
. $(dirname "$0")/config.inc

docker restart $appname_mysql
docker restart $appname_mail
docker restart $appname
docker restart $appname_nginx