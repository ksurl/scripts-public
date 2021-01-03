#!/bin/bash

if [ ! -d Hama.bundle ]; then
  git clone https://github.com/ZeroQI/Hama.bundle
fi

cd Hama.bundle

git pull

cd ..

docker cp Hama.bundle plex:'/config/Library/Application Support/Plex Media Server/Plug-ins'
