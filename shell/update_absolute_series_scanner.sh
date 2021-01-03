#!/bin/sh

path='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Scanners/Series'
wget -O "$path/Absolute Series Scanner.py" https://raw.githubusercontent.com/ZeroQI/Absolute-Series-Scanner/master/Scanners/Series/Absolute%20Series%20Scanner.py
chown plex:plex "$path/Absolute Series Scanner.py"
chmod 755 "$path/Absolute Series Scanner.py"
