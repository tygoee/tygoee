From <https://www.tecmint.com/install-nvidia-drivers-in-linux/>

1. First exit gnome-software. To install the repositories and fetch them, run these commands:

```sh
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
```

2. The drivers should show in the Software Center. Install 'Nvidia Linux Graphics driver' (without a specified version, such as `470xx` or `390xx`)
 
   > If they don't show up, install `akmod-nvidia-3`

3. Reboot to apply the drivers

   > When the drivers don't work, try to install
   > `kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig`
   > and reinstall the nvidia driver
