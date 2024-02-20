#!/bin/bash

sudo apt install -y wget

wget https://vault.bitwarden.com/download/?app=desktop\&platform=linux\&variant=deb -O ~/Downloads/bitwarden.deb

sudo apt install -y ~/Downloads/bitwarden.deb