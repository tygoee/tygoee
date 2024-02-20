#!/bin/bash

sudo apt install -y wget

wget https://discord.com/api/download?platform=linux\&format=deb -O ~/Downloads/discord.deb

sudo apt install -y ~/Downloads/discord.deb