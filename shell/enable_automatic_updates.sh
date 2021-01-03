#!/bin/bash

installed=$(dpkg -l | grep unattended-upgrades)

if [ $installed == "" ]; then
  apt-get install -y unattended-upgrades
fi

echo "APT::Periodic::Update-Package-Lists \"1\";
	APT::Periodic::Download-Upgradeable-Packages \"1\";
	APT::Periodic::AutocleanInterval \"5\";
	APT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/10periodic"
