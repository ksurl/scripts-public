#!/bin/bash

# This script installs the unifi controller software with dependencies: 
# Ubuntu 18.04 LTS
# MongoDB 3.4.x
# OpenJDK Java 8

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

apt-get update
apt-get install -y mongodb-org
echo "mongodb-org hold" | dpkg --set-selections
apt-get install -y jsvc openjdk-8-jre libcommons-daemon-java
echo "openjdk-8-jre hold" | dpkg --set-selections
echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list

#wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg
apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 
apt-get update

apt-get install -y unifi
