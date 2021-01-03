#!/bin/bash

add-apt-repository ppa:wireguard/wireguard
apt-get install -y wireguard

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.proxy_arp = 1
sysctl -p /etc/sysctl.conf

(umask 077 && printf "[Interface]\nPrivateKey = " | tee /etc/wireguard/wg0.conf > /dev/null)
wg genkey | tee -a /etc/wireguard/wg0.conf | wg pubkey | tee /etc/wireguard/wg.pub

echo "ListenPort = 51280
SaveConfig = false
Address = 10.0.0.1/24
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens18 -j MASQUERADE

[Peer]
PublicKey = PUBLIC_KEY
AllowedIPs = 10.0.0.2/32
" >> /etc/wireguard/wg0.conf

wg-quick up wg0
systemctl enable wg-quick@wg0
