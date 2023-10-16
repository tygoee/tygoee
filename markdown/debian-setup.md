# Debian setup

These are instructions on how I've setup my personal debian 12 installation. These actions are for after the installation with no grapical environment and `standard system utilities` installed. This assumes your user is `tygoe` (me).

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
sudo nano /etc/profile # Add /sbin to PATH
sudo chown root:root /sbin/reboot /sbin/shutdown
sudo chmod +s /sbin/reboot /sbin/shutdown
```

## Install xorg and openbox, and `startx`

```shell
sudo apt install xorg openbox
startx # If it doesn't work, reboot
```

## Install nice packages

Exit openbox first, and then:

```shell
# Browser, terminal, file manager
sudo apt install firefox-esr alacritty thunar

# Taskbar
sudo apt install tint2 volumeicon-alsa cbatticon

# Drivers and compatibility
sudo apt install pulseaudio network-manager-gnome xcompmgr ibus
sudo apt install xdg-utils psmisc pkexec xdotool ca-certificates pavucontrol

# Other apps
sudo apt install rclone feh obs-studio

# Programing
sudo apt install python3-pip python3-venv curl git
```

Reboot for some of these to complete their installation

## Configure the packages

### _alacritty_

WIP...
