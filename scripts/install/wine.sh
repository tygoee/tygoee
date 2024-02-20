#!/bin/bash

sudo apt install -y wget gnupg2 lsb-release

sudo dpkg --add-architecture i386
wget -qO- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor | sudo tee /usr/share/keyrings/winehq.gpg > /dev/null
echo deb "[signed-by=/usr/share/keyrings/winehq.gpg] http://dl.winehq.org/wine-builds/debian/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/winehq.list

sudo apt update
sudo apt install -y winehq-stable --install-recommends
sudo apt install -y wine64 wine32
