#!/bin/bash
#
# Before this, run install_pkgs.sh
#

# -- Make shutdown and reboot available -- #
# Add the necesarry permissions
sudo chown root:root /sbin/reboot /sbin/shutdown
sudo chmod +s /sbin/reboot /sbin/shutdown

# Make symlinks
ln -s /sbin/shutdown /bin/shutdown
ln -s /sbin/reboot /bin/reboot

# -- Copy all the config files -- #
cp -r tygoee/configs/home/. ~/
sudo cp -r tygoee/configs/root/. /root/

# -- Setup openbox -- #
# Install the theme
git clone https://github.com/ju1464/E5150_Themes
cp -r E5150_Themes/GTK-Gnome/E5150-Blue/ ~/.themes/

# Download the image
wget -O ~/.config/openbox/background.jpg https://wallpapers.com/images/hd/golden-peak-mountain-k4xggmniraiyie6h.jpg --user-agent="Mozilla"

# Use the enhanced obamenu (backup the existing one)
sudo cp tygoee/scripts/obamenu /usr/bin/obamenu

# Setup 'tap to click'
mkdir -p /etc/X11/xorg.conf.d
echo 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection' | sudo tee /etc/X11/xorg.conf.d/40-libinput.conf

# Make a screenshots directory
mkdir -p ~/Pictures/Screenshots

# -- Setup alacritty -- #
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# -- Setup gdebi -- #
sudo sed -i 's/^Exec=gdebi-gtk %f$/Exec=sh -c "gdebi-gtk %f"/' /usr/share/applications/gdebi.desktop

# -- Setup NetworkManager -- #
sudo sed -i 's/^/# /' "/etc/network/interfaces"
sudo systemctl enable NetworkManager.service

# -- Install nvidia drivers (last thing before reboot) -- #
sudo add-apt-repository contrib non-free -y
sudo apt install -y nvidia-driver
/sbin/reboot
