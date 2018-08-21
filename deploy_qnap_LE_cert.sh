#!/bin/bash

# ASSUMPTIONS:
# - passwordless ssh key
# - ssh config file specifies username and ssh key for $qnap
# - runs as user (using ~ for default acme.sh install location)

# change this:
domain="DOMAIN"
qnap="HOSTNAME"

cat ~/.acme.sh/$domain/$domain.key ~/.acme.sh/$domain/$domain.cer ~/.acme.sh/$domain/ca.cer > /tmp/stunnel.pem
ssh $qnap "mv /etc/stunnel/stunnel.pem /etc/stunnel/stunnel.pem.back"
scp /tmp/stunnel.pem $qnap:/etc/stunnel/stunnel.pem &>/dev/null

ssh $qnap chmod 600 /etc/stunnel/stunnel.pem &>/dev/null
ssh $qnap /etc/init.d/Qthttpd.sh stop &>/dev/null
ssh $qnap /etc/init.d/stunnel.sh restart &>/dev/null
ssh $qnap /etc/init.d/Qthttpd.sh start &>/dev/null

rm -f /tmp/stunnel.pem
