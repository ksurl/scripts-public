#!/bin/bash

# change these variables
zone_identifier=ZONE_ID
dns_record_identifier=DNS_RECORD_ID
cloudflare_email=EMAIL
cloudflare_auth_key=API_KEY
domain="DOMAIN"

hourstamp=$(date +"%F-%H")
past_ip=$(cat ~/.config/ddns/ip.log)
publicip=$(curl https://api.ipify.org 2>/dev/null)
if [ $past_ip = $publicip ]; then
    exit 1
fi

echo $publicip > ~/.config/ddns/ip.log
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$dns_record_identifier" \
     -H "X-Auth-Email: $cloudflare_email" \
     -H "X-Auth-Key: $cloudflare_auth_key" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":'\"$domain\"',"content":'\"$publicip\"',"ttl":1,"proxied":false}' > /dev/null

printf "$hourstamp: Changed IP address of ddns to $publicip \n" >> ~/.config/ddns/ddns.log
