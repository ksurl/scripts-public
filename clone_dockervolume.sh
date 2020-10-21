#!/bin/bash

# check for arguments
if [ "$1" = "" ]; then
  echo "no source volume"
  exit
fi

if [ "$2" = "" ]; then
  echo "no destination volume"
  exit
fi

# check if source volume exists
docker volume ls | grep $1 > /dev/null 2>&1
if [ "$?" != "1" ]; then
  echo "source volume $1 doesn't exist"
  exit
fi

# check if destination volume exists
docker volume ls | grep $2 > /dev/null 2>&1
if [ "$?" = "1" ]; then
  echo "creating volume $2"
  docker volume create --name $2 > /dev/null 2>&1
fi

echo "cloning $1 to $2"
docker run --rm -v $1:/volume:ro loomchild/volume-backup backup -c none - |\
docker run --rm -i -v $2:/volume loomchild/volume-backup restore -c none -
