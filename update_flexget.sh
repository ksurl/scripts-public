#!/bin/bash

systemctl --user stop flexget
source ~/.venv/flexget/bin/activate
pip install -U flexget
deactivate
systemctl --user start flexget
