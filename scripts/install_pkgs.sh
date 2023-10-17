#!/bin/bash

# Browser, terminal, file manager
sudo apt install -y firefox-esr alacritty thunar

# Taskbar
sudo apt install -y tint2 volumeicon-alsa cbatticon

# Drivers and compatibility
sudo apt install -y pulseaudio network-manager-gnome xcompmgr ibus
sudo apt install -y xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol wget curl software-properties-common at-spi2-core bash-completion

# Other apps
sudo apt install -y rclone feh obs-studio

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft-archive-keyring.asc
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update # Update the package list

# Programming
sudo apt install -y python3-pip python3-venv git code