#!/bin/bash

mkdir /etc/caddy
chown -R root:www-data /etc/caddy
mkdir /etc/ssl/caddy
chown -R www-data:root /etc/ssl/caddy
chmod 0770 /etc/ssl/caddy
touch /etc/caddy/Caddyfile
mkdir /var/www
chown www-data: /var/www
