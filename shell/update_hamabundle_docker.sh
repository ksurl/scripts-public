#!/bin/bash

if [ ! -d Hama.bundle ]; then
  git clone https://github.com/ZeroQI/Hama.bundle
fi

git -C Hama.bundle pull

docker cp Hama.bundle plex:'/config/Library/Application Support/Plex Media Server/Plug-ins'
