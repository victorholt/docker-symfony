#!/bin/bash
cd /var/www
bin/console doctrine:schema:update --force
bin/console assets:install
cc