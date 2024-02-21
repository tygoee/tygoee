#!/bin/bash

sudo apt -y install lightdm

wget https://raw.githubusercontent.com/canonical/lightdm/main/debian/lightdm-session
chmod +x lightdm-session
sudo cp lightdm-session /usr/sbin/lightdm-session

sudo sed -i 's/^#session-wrapper/session-wrapper/' /etc/lightdm/lightdm.conf