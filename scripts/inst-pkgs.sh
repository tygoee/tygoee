#!/bin/bash

apt_apps=(
    # Terminal and file manager
    alacritty thunar

    # Taskbar
    tint2 volumeicon-alsa cbatticon

    # Drivers
    pulseaudio network-manager-gnome ibus

    # For compatibility and possibly uninstalled
    xdg-utils psmisc pkexec xdotool ca-certificates-java
    at-spi2-core snapd debian-keyring debian-archive-keyring

    # Some nice features
    bash-completion picom command-not-found

    # Other apps
    feh obs-studio copyq gdebi thunderbird pavucontrol

    # Programming
    python3-pip python3-venv git
)

snap_apps=(
    whatsdesk p7zip-desktop
)

# Make the Downloads dir
mkdir -p ~/Downloads

sudo add-apt-repository contrib non-free -y
sudo apt install -y "${apt_apps[@]}"
sudo snap install "${snap_apps[@]}"
