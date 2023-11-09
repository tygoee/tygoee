# Debian setup

These are instructions on how I've setup my personal debian 12 installation. These actions are for after the installation with no grapical environment and `standard system utilities` installed. This assumes your user is `tygoe` (me), but _tries_ to avoid usernames. Also enable 3D acceleration in Virtualbox.

#### To do this faster:

- Install and configure sudo
- Make shutdown and root available
- Do the rest with automated scripts:

```shell
git clone https://github.com/tygoee/tygoee
cd tygoee

# Install packages
sudo apt install xorg openbox
./scripts/install_pkgs.sh

# Setup everything
./scripts/setup-0.sh # this will reboot
./scripts/setup-1.sh # requires user interaction
```

## Install and configure sudo

```shell
su
apt install sudo
sudo visudo
#- Change all the lines ending with `ALL` to `NOPASSWD: ALL`
sudo adduser tygoe sudo
su tygoe
```

## Install all packages

First, clone the git repo:

```shell
sudo apt install git
git clone https://github.com/tygoee/tygoee
cd tygoee
```

Then install all packages. You can use [`scripts/install_pkgs.sh`](../scripts/install_pkgs.sh) to install all packages automatically:

```shell
./scripts/install_pkgs.sh
```

Reboot for some of these to complete their installation

## Configure the packages

Now, configure all these apps automatically using [`scripts/setup-0.sh`](../scripts/setup-0.sh). If that's done, it will reboot and you need to execute [`scripts/setup-1.sh`](../scripts/setup-1.sh):

```shell
./scripts/setup-0.sh
./scripts/setup-1.sh
```

If you want to do it manually anyway, continue. Otherwise, you're done :)

---

Copy all config files first:

```shell
cp -r ./configs/home/. ~/
sudo cp -r ./configs/root/. /root/
```

Then, to make shutdown and reboot available to all users:

```shell
# Add the necesarry permissions
sudo chown root:root /sbin/reboot /sbin/shutdown
sudo chmod +s /sbin/reboot /sbin/shutdown

# Make symlinks
ln -s /sbin/shutdown /bin/shutdown
ln -s /sbin/reboot /bin/reboot
```

### _openbox_

```shell
# Install the theme
mkdir -p ~/.themes/
git clone https://github.com/ju1464/E5150_Themes
cp -r E5150_Themes/GTK-Gnome/E5150-Blue/ ~/.themes/

# Download the image
wget -O ~/.config/openbox/background.jpg https://wallpapers.com/images/hd/golden-peak-mountain-k4xggmniraiyie6h.jpg --user-agent="Mozilla"

# Use the enhanced obamenu (backup the existing one)
sudo cp ./scripts/obamenu /usr/bin/obamenu

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
```

### _alacritty_

```shell
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
```

### _gdebi_

```shell
sudo sed -i 's/^Exec=gdebi-gtk %f$/Exec=sh -c "gdebi-gtk %f"/' /usr/share/applications/gdebi.desktop
```

### _network-manager_

```shell
sudo sed -i 's/^/# /' "/etc/network/interfaces"
sudo systemctl enable NetworkManager.service
```

### _nvidia-driver_

```shell
sudo add-apt-repository contrib non-free
sudo apt install nvidia-drivers
reboot
```

### _rclone_

```shell
mkdir ~/OneDrive
rclone config #- Fill in everything (needs GUI)
echo '[Unit]
Description=rclone mount
After=network-online.target

[Service]
User=tygoe
ExecStartPre=/bin/sleep 10
ExecStart=/usr/bin/rclone --vfs-cache-mode writes --dir-cache-time 10s mount \"OneDrive:\" /home/tygoe/OneDrive

[Install]
WantedBy=default.target' | sudo tee /etc/systemd/system/rclone.service
```

### _git_

First, make a gpg key and add it to your github account:

```shell
# Generate a key
gpg --full-generate-key

# Print your gpg key
gpg --list-secret-keys --keyid-format=long

# Export your public gpg key
gpg --armor --export YOUR_SIGNING_KEY
```

```shell
# Set the username and email
git config --global user.name USERNAME
git config --global user.email EMAIL

# Set the signing key and enable it
git config --global user.signingkey YOUR_SIGNING_KEY
git config --global commit.gpgsign true
```

And you're done :)
