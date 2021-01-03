#!/bin/bash

backup="/path/backup/folder"

ts=$(date +%Y%m%d%H%M%S)

echo "Starting docker volume backup at $ts"

for j in `docker volume ls | grep local | awk '{print $2}'`
do
  if [ ! -d "$backup/$j" ]; then
    echo "Creating backup folder $j"
    mkdir "$backup/$j"
  fi
  echo "Backing up $j"
  docker run --rm -v $j:/volume:ro loomchild/volume-backup backup -v - > \
  "$backup/$j/$j-$ts.tar.bz2"
done

echo "Cleaning up old backups"

for i in `ls -1t $backup`;
do
  for k in `ls -1t $backup/$i | tail -n +5`;
  do
    echo "Deleting $k"
    rm -f $backup/$i/$k
  done
done
