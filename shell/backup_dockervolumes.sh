#!/bin/bash

host=$1
type=$2

logfile="/var/log/dockerbackup/$host/$type-backup.log"
dst="/mnt/storage/backup/$host/$type"

notify_discord()
{
  local ts=$(date)
  local webhook="https://discord.com/api/webhooks/X/Y" # replace with your webhook
  curl $webhook \
  -H "Content-Type: application/json" \
  -X POST \
  -d @<(cat <<EOF
{
  "embeds": [
    {
      "fields": [
        {
          "name": "Host",
          "value": "$host"
        },        
        {
          "name": "Backup Type",
          "value": "$type"
        },
        {
          "name": "Backup Status",
          "value": "$1"
        },
        {
          "name": "Timestamp",
          "value": "$ts"
        }
      ],
      "color": "$2"
    }
  ]
}
EOF
)
}

backup_bindmounts () {
  local ts=$(date +%Y-%m-%d-%H.%M.%S)
  local src=$1
  for j in `ls -1 $src`;
  do
    if [ ! -d "$dst/$j" ]; then
      echo "Creating backup folder $j" >> "$logfile"
      mkdir -p "$dst/$j"
    fi
    echo "Backing up $j" >> "$logfile"
    tar -I zstd -cpf "$dst/$j/$j-$ts.tar.zstd" "$src/$j"
  done
}

backup_volumes () {
  local ts=$(date +%Y-%m-%d-%H.%M.%S)
  for j in `docker volume ls | grep local | awk '{print $2}'`;
  do
    if [ ! -d "$dst/$j" ]; then
      echo "Creating backup folder $j" >> "$logfile"
      mkdir -p "$dst/$j"
    fi
    echo "Backing up $j" >> "$logfile"
    docker run --rm -v $j:/volume:ro ghcr.io/ksurl/volume-backup backup -c zstd - > "$dst/$j/$j-$ts.tar.zstd"
  done
}

prune_backups () {
  for i in `ls -1t $dst`;
  do
    for k in `ls -1t $dst/$i | tail -n +5`;
    do
      echo "Deleting $k" >> "$logfile"
      rm -f $dst/$i/$k
    done
  done
}

echo "Starting $host $type backup" > "$logfile"
notify_discord "started" "12566463" # grey

if [ $host == "remote" ]; then
  rsync -avP -e ssh $host:/opt/docker/config /mnt/storage/backup/$host/docker # replace with your host and backup path
fi

case "$type" in
  bindmount)
    if [ $host == "local" ]; then
      backup_bindmounts "/opt/docker/config" # replace with your bindmount path
    fi
    if [ $host == "remote" ]; then
      backup_bindmounts "/mnt/storage/backup/$host/docker" # replace iwth your host and bindmount path
    fi      
    ;;
  volume)
    backup_volumes
    ;;
  *)
    ;;
esac

echo "Cleaning up old backups" >> "$logfile"
prune_backups
echo "Backup complete" >> "$logfile"
notify_discord "completed" "6729778" # green
