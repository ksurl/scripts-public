#!/bin/sh

wget -q -O "Absolute Series Scanner.py" https://raw.githubusercontent.com/ZeroQI/Absolute-Series-Scanner/master/Scanners/Series/Absolute%20Series%20Scanner.py

docker cp "Absolute Series Scanner.py" plex:'/config/Library/Application Support/Plex Media Server/Scanners/Series'
