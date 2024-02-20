#!/bin/bash

sudo apt install -y curl wget gnupg2 lsb-release

# Download VirtualBox
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/vbox.gpg
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list &>/dev/null

sudo apt update
sudo apt install -y "linux-headers-$(uname -r)" dkms virtualbox-7.0

# Download VirtualBox Extension Pack
version=$(vboxmanage -v | cut -dr -f1)
wget -q "https://download.virtualbox.org/virtualbox/$version/Oracle_VM_VirtualBox_Extension_Pack-$version.vbox-extpack"
sudo vboxmanage extpack install "Oracle_VM_VirtualBox_Extension_Pack-$version.vbox-extpack" --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c

