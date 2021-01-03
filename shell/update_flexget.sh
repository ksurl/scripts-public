#!/bin/sh

systemctl --user stop flexget
~/.venv/flexget/bin/pip install -U flexget
systemctl --user start flexget
