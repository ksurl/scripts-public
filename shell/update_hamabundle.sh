#!/bin/sh

path='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/Hama.bundle'
cd "$path"
git fetch --all
git reset --hard origin/master
chown -R plex:plex "$path"
chmod -R 755 "$path"
