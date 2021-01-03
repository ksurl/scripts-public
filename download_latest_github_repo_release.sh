#!/bin/bash

curl -s https://api.github.com/repos/user/repo/releases/latest \
| grep "browser_download_url.*filename.ext" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
