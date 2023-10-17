# Debian setup

These are instructions on how I've setup my personal debian 12 installation. These actions are for after the installation with no grapical environment and `standard system utilities` installed. This assumes your user is `tygoe` (me), but _tries_ to avoid usernames.

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
sudo apt install pulseaudio network-manager-gnome xcompmgr ibus
sudo apt install xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol wget curl software-properties-common at-spi2-core bash-completion

# Other apps
sudo apt install rclone feh obs-studio

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Programming
sudo apt install python3-pip python3-venv git code
```

Reboot for some of these to complete their installation

## Configure the packages

Before anything else, clone this repo:

```shell
git clone https://github.com/tygoee/tygoee
```

And copy all config files:

```shell
cp -r tygoee/configs/home/* ~/
sudo cp -r tygoee/configs/root/* /root/
```

### _openbox_

```shell
# Install the theme
mkdir -p ~/.themes
git clone https://github.com/ju1464/E5150_Themes
cp -r E5150_Themes/GTK-Gnome/E5150-Blue/ ~/.themes/

# Download the image=
wget -O ~/.config/openbox/background.jpg https://wallpapers.com/images/hd/golden-peak-mountain-k4xggmniraiyie6h.jpg --user-agent="Mozilla"

# Add WINIT_SCALE_FACTOR to ~/.profile
echo "export WINIT_X11_SCALE_FACTOR=1.66" >> ~/.profile

# Warning: change this file for your monitor layout,
# if you only have one monitor, make the file empty
chmod +x ~/.config/openbox/monitors.sh
```

### _alacritty_

WIP...

<!-- How I installed from gnome-look.org:
mkdir -p ~/.themes/
curl -Lfs https://www.gnome-look.org/p/1330547/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | grep "E5150-Blue" | xargs wget
tar -xf E5150-Blue.tar.gz -C ~/.themes/
-->
