!#/bin/bash

cat /path/file | while read line || [[ -n $line ]];
do
  # do stuff here
  echo "$line"
done
