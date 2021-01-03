#!/bin/bash

backup="/path/folder"

echo "Starting docker volume restore"

for i in `ls -1t $backup`;
do
  if [[ $(docker volume ls | grep $i) == "" ]]; then
    echo "Creating volume $i"
    docker volume create $i
  fi
  echo "Restoring $i"
  archive=$(ls -1t $backup/$i | head -1)
  docker run --rm -v $i:/volume -v $backup/$i:/backup loomchild/volume-backup restore -v $archive
done
