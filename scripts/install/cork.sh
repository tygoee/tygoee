#!/bin/bash

# Download all required packages and libraries
sudo apt install -y wget curl git build-essential cmake
sudo apt install -y libboost-all-dev libzip-dev zlib1g-dev libbz2-dev liblzma-dev libssl-dev libcurl4-openssl-dev liblua5.4-dev

# Get the proton url and filename
result=$(curl -s https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest)

url=$(echo "$result" | grep '"browser_download_url":.*\.tar\.xz"' | awk -F\" '{print $4}')
name=$(echo "$result" | grep '"name":.*\.tar\.xz"' | awk -F\" '{print $4}')

# Proton
mkdir -p ~/.local/lib/
wget -P ~/.local/lib/ "$url"
echo "Extracting $name..."
tar -xJf ~/.local/lib/"$name" -C ~/.local/lib/

# Cork
git clone https://github.com/CorkHQ/Cork.git
cd Cork || exit 1
mkdir build
cmake -Bbuild -H. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DCPR_USE_SYSTEM_CURL=ON
cd build || :
cmake --build . --target all
cmake --install . --prefix ~/.local