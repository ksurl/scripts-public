#!/bin/sh

rm -f /etc/vmware/license.cfg
cp /etc/vmware/#.license.cfg /etc/vmware/license.cfg
/etc/init.d/vpxa restart
