#!/bin/bash

# Browser, terminal, file manager
sudo apt install -y firefox-esr alacritty thunar

# Taskbar
sudo apt install -y tint2 volumeicon-alsa cbatticon

# Drivers and compatibility
sudo apt install -y pulseaudio network-manager-gnome ibus
sudo apt install -y xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol wget curl software-properties-common at-spi2-core bash-completion

# Other apps
sudo apt install -y rclone feh obs-studio copyq gdebi thunderbird

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft-archive-keyring.asc
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update # Update the package list

# Programming
sudo apt install -y python3-pip python3-venv git code

# Some non-default-apt apps
wget https://vault.bitwarden.com/download/?app=desktop\&platform=linux\&variant=deb -O ~/Downloads/bitwarden.deb
sudo apt install -y ~/Downloads/bitwarden.deb

wget https://discord.com/api/download?platform=linux\&format=deb -O ~/Downloads/Minecraft.deb
sudo apt install -y ~/Downloads/Minecraft.deb

curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install -y speedtest