#!/bin/sh

# ASSUMPTIONS:
# - passwordless ssh key
# - ssh config file specifies username and ssh key for $esxihost
# - runs as user (using ~ for default acme.sh install location)

# change this:
domain="DOMAIN"
esxihost="HOSTNAME"

ssh $esxihost "mv /etc/vmware/ssl/castore.pem /etc/vmware/ssl/castore.pem.back"
ssh $esxihost "mv /etc/vmware/ssl/rui.crt /etc/vmware/ssl/rui.crt.back"
ssh $esxihost "mv /etc/vmware/ssl/rui.key /etc/vmware/ssl/rui.key.back"

scp ~/.acme.sh/$domain/fullchain.cer $esxihost:/etc/vmware/ssl/castore.pem
scp ~/.acme.sh/$domain/$domain.cer $esxihost:/etc/vmware/ssl/rui.crt
scp ~/.acme.sh/$domain/$domain.key $esxihost:/etc/vmware/ssl/rui.key

ssh $esxihost "/sbin/services.sh restart"
