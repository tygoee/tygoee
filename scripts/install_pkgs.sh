#!/bin/bash

apt_apps=(
    # Xorg and openbox
    xorg openbox

    # Browser, terminal, file manager
    firefox-esr alacritty thunar

    # Taskbar
    tint2 volumeicon-alsa cbatticon

    # Drivers
    pulseaudio network-manager-gnome ibus

    # For compatibility and possibly uninstalled
    xdg-utils psmisc pkexec xdotool ca-certificates ca-certificates-java
    wget curl software-properties-common at-spi2-core snapd
    debian-keyring debian-archive-keyring apt-transport-https

    # Some nice features
    bash-completion picom command-not-found

    # Other apps
    feh obs-studio copyq gdebi thunderbird speedtest pavucontrol
    ~/Downloads/bitwarden.deb ~/Downloads/discord.deb ~/Downloads/Minecraft.deb

    # Programming
    python3-pip python3-venv git code

    # Wine
    winehq-stable

    # Cork
    build-essential cmake
    libboost-all-dev libzip-dev zlib1g-dev libbz2-dev liblzma-dev
    libssl-dev curl libcurl4-openssl-dev liblua5.4-dev

    # VirtualBox
    lsb-release "linux-headers-$(uname -r)" dkms
    virtualbox-7.0
)

snap_apps=(
    # Whatsapp
    whatsdesk
)

# Install the needed dependencies
sudo apt install -y software-properties-common wget curl gnupg2

# Add Wine
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -qNP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources

# Add VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft-archive-keyring.asc &>/dev/null
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Add Virtualbox
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/vbox.gpg
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list &>/dev/null

# Add some other non-default-apt apps
echo -n "Downloading bitwarden... "
wget -q https://vault.bitwarden.com/download/?app=desktop\&platform=linux\&variant=deb -O ~/Downloads/bitwarden.deb

echo -en "Done\nDownloading discord... "
wget -q https://discord.com/api/download?platform=linux\&format=deb -O ~/Downloads/discord.deb

echo -en "Done\nDownloading minecraft... "
wget -q https://launcher.mojang.com/download/Minecraft.deb -P ~/Downloads/

echo -en "Done\nDownloading speedtest-cli... Done\nUpdating package lists... "
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash &>/dev/null
echo "Done"

sudo apt install -y "${apt_apps[@]}"
sudo snap install "${snap_apps[@]}"

# Proton
mkdir -p ~/.local/lib/
wget -P ~/.local/lib/ https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-22/wine-lutris-GE-Proton8-22-x86_64.tar.xz
echo "Extracting lutris-GE-Proton8-22-x86_64..."
tar -xJf ~/.local/lib/wine-lutris-GE-Proton8-22-x86_64.tar.xz -C ~/.local/lib/

# Cork
git clone https://github.com/CorkHQ/Cork.git
cd Cork || exit 1
mkdir build
cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DCPR_USE_SYSTEM_CURL=ON
cd build || :
cmake --build . --target all
cmake --install . --prefix ~/.local