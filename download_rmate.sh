#!/bin/sh

if [ ! -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

wget -O ~/.local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate

chmod u+x ~/.local/bin/rmate
