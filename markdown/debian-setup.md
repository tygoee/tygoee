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

## Make shutdown and reboot available

```shell
sudo nano /etc/profile #- Add /sbin to PATH
sudo chown root:root /sbin/reboot /sbin/shutdown
sudo chmod +s /sbin/reboot /sbin/shutdown
```

## Install xorg and openbox, and `startx`

```shell
sudo apt install xorg openbox
startx # If it doesn't work, reboot
```

## Install nice packages

Exit openbox first, and then install all packages. You can use [scripts/install_pkgs.sh](../scripts/install_pkgs.sh) or install them yourself:

```shell
# Browser, terminal, file manager
sudo apt install firefox-esr alacritty thunar

# Taskbar
sudo apt install tint2 volumeicon-alsa cbatticon

# Drivers and compatibility
sudo apt install pulseaudio network-manager-gnome ibus
sudo apt install xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol wget curl software-properties-common at-spi2-core bash-completion picom debian-keyring debian-archive-keyring apt-transport-https

# Other apps
sudo apt install rclone feh obs-studio copyq gdebi thunderbird

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft-archive-keyring.asc
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update # Update the package list

# Programming
sudo apt install python3-pip python3-venv git code

# Some non-default-apt apps
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb" -P ~/Downloads/bitwarden.deb
sudo apt install ~/Downloads/bitwarden.deb

wget https://discord.com/api/download?platform=linux\&format=deb -O ~/Downloads/discord.deb
sudo apt install ~/Downloads/discord.deb

curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install speedtest
```

Reboot for some of these to complete their installation

## Configure the packages

Before anything else, clone this repo:

```shell
git clone https://github.com/tygoee/tygoee
```

And copy all config files:

```shell
cp -r tygoee/configs/home/. ~/
sudo cp -r tygoee/configs/root/. /root/
```

### _openbox_

```shell
# Install the theme
mkdir -p ~/.themes
git clone https://github.com/ju1464/E5150_Themes ~/.themes/

# Download the image
wget -O ~/.config/openbox/background.jpg https://wallpapers.com/images/hd/golden-peak-mountain-k4xggmniraiyie6h.jpg --user-agent="Mozilla"

# Add WINIT_SCALE_FACTOR to ~/.profile
echo -e "\nexport WINIT_X11_SCALE_FACTOR=1.66" >> ~/.profile

# Use the enhanced obamenu (backup the existing one)
sudo cp tygoee/scripts/obamenu /usr/bin/obamenu

# Enable 'tap to click'
mkdir -p /etc/X11/xorg.conf.d
echo 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection' | sudo tee /etc/X11/xorg.conf.d/40-libinput.conf
```

### _alacritty_

```shell
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --config x-terminal-emulator
```

### _network_manager_

```shell
sudo sed -i 's/^/# /' "/etc/network/interfaces"
sudo systemctl enable NetworkManager.service
reboot
nmtui #- Connect the network
```

### _git_

```shell
git config --global user.name tygoee
git config --global user.email tygoee@outlook.com
git config --global user.signingkey YOUR_SIGNING_KEY
git config --global commit.gpgsign true
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

... (WIP)

<!-- How I installed from gnome-look.org:
mkdir -p ~/.themes/
curl -Lfs https://www.gnome-look.org/p/1330547/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | grep "E5150-Blue" | xargs wget
tar -xf E5150-Blue.tar.gz -C ~/.themes/
-->
