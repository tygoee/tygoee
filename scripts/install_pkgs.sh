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

# Wine
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
sudo apt update

sudo apt install --install-recommends winehq-stable

# Proton
mkdir -p ~/.local/lib/
wget -P ~/.local/lib/ https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-22/wine-lutris-GE-Proton8-22-x86_64.tar.xz
tar -xJf ~/.local/lib/wine-lutris-GE-Proton8-22-x86_64.tar.xz -C ~/.local/lib/

# Cork
sudo apt install git build-essential cmake
sudo apt install libboost-all-dev libzip-dev zlib1g-dev libbz2-dev liblzma-dev libssl-dev curl libcurl4-openssl-dev liblua5.4-dev
git clone https://github.com/CorkHQ/Cork.git
cd Cork || :
mkdir build
cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DCPR_USE_SYSTEM_CURL=ON
cd build || :
cmake --build . --target all
cmake --install . --prefix ~/.local