#!/bin/bash

current_ip=$(curl -fsSL http://checkip.amazonaws.com)
cached_ip=$(cat ~/.config/ddns/ip.txt)

API="PUSHBULLET_API_KEY"
TITLE="DDNS"
MSG="New IP: $current_ip"

if [ "$current_ip" != "$cached_ip" ]; then
  echo "$current_ip" > ~/.config/ddns/ip.txt
  curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="$TITLE" -d body="$MSG" > /dev/null
  #echo "New IP: $current_ip"
else
  echo "IP has not changed"
fi
