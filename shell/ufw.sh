#!/bin/sh

ufw disable

ufw --force reset

# deny defaults
ufw default deny incoming
ufw default deny outgoing

# allow local network
ufw allow from 10.0.1.10
ufw allow from 127.0.0.1

# allow dns, openvpn, and smb
ufw allow out 53
ufw allow out 1194/udp
ufw allow out 445/tcp

# deny deluge on eth0 (change port as needed)
ufw deny out on eth0 to any port 49164
ufw deny in on eth0 to any port 49164

# allow deluge in and all outgoing on tunnel
ufw allow in on tun0 to any port 49164
ufw allow out on tun0

ufw enable
