#!/bin/bash

# ASSUMPTIONS:
# - passwordless ssh key
# - ssh config file specifies username and ssh key for $esxihost
# - runs as user (using ~ for default acme.sh install location)

# change this:
domain="DOMAIN"
router="HOSTNAME"

# cert files
key=~/.acme.sh/$domain/$domain.key
cert=~/.acme.sh/$domain/$domain.cer

# install cert
cat $key $cert > /tmp/server.pem
ssh $router sudo cp /etc/lighttpd/server.pem /etc/lighttpd/server.pem.bak
scp /tmp/server.pem $router:/tmp/
ssh $router sudo mv /tmp/server.pem /etc/lighttpd/server.pem

# restart web gui
ssh $router sudo kill -SIGTERM $(ps -e | grep lighttpd | awk '{print $1;}')
ssh $router sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf

rm -f /tmp/server.pem
