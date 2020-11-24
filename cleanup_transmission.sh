#!/bin/bash

# docker
#bin='docker exec transmission /usr/bin/transmission-remote'
 
bin='/usr/bin/transmission-remote'

# use if you have authentication enabled
#bin='/usr/bin/trasmission-remote  --auth user:password'

for item in `$bin -l | grep 100%.*Done`; do
    ID=`echo $item | sed "s/^ *//g" | sed "s/ *100%.*//g"`
    $bin -t $ID -r
done
