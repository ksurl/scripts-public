#!/bin/bash

apt-get update

apt-get install -y git vim cifs-utils apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install docker-ce

curl -s https://api.github.com/repos/docker/compose/releases/latest \
| grep "browser_download_url.*docker-compose-Linux-x86_64" \
| grep -v sha256
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -O /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
