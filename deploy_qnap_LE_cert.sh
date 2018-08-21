#!/bin/bash

# this script assumes you have ssh config setup for HOST and the NAS has added the public key to authorized_keys

# Replace DOMAIN and PATH to match your configuration

# Domains to grab cert for
DOMAIN="example.com"

# Path to letsencrypt cert files
CERTPATH="$PATH/.acme.sh/$DOMAIN"

cat "$CERTPATH/$DOMAIN.key" "$CERTPATH/$DOMAIN.cer" "$CERTPATH/ca.cer" > /tmp/stunnel.pem
scp /tmp/stunnel.pem HOST:/etc/stunnel/stunnel.pem &>/dev/null
ssh HOST chmod 600 /etc/stunnel/stunnel.pem &>/dev/null
ssh HOST /etc/init.d/Qthttpd.sh stop &>/dev/null
ssh HOST /etc/init.d/stunnel.sh restart &>/dev/null
ssh HOST /etc/init.d/Qthttpd.sh start &>/dev/null
rm -f /tmp/stunnel.pem
