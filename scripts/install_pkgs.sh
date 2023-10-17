#!/bin/bash

# Browser, terminal, file manager
sudo apt install firefox-esr alacritty thunar

# Taskbar
sudo apt install tint2 volumeicon-alsa cbatticon

# Drivers and compatibility
sudo apt install pulseaudio network-manager-gnome xcompmgr ibus
sudo apt install xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol wget curl software-properties-common at-spi2-core bash-completion

# Other apps
sudo apt install rclone feh obs-studio

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Programming
sudo apt install python3-pip python3-venv git code