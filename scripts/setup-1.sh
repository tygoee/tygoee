#!/bin/bash

# -- Setup rclone -- #
# Make the directory
mkdir ~/OneDrive

# Configure rclone
rclone config #- Fill in everything (needs GUI)

# Create the systemd service
echo '[Unit]
Description=rclone mount
After=network-online.target

[Service]
User=tygoe
ExecStartPre=/bin/sleep 10
ExecStart=/usr/bin/rclone --vfs-cache-mode writes --dir-cache-time 10s mount \"OneDrive:\" /home/tygoe/OneDrive

[Install]
WantedBy=default.target' | sudo tee /etc/systemd/system/rclone.service

# Reload and enable the systemd service
sudo systemctl daemon-reload
sudo systemctl enable rclone.service
sudo systemctl start rclone.service

# -- Setup Git -- #
# Configure git
git config --global user.name "tygoee"
git config --global user.email "tygoee@outlook.com"
git config --global commit.gpgsign true

echo "Make sure to create a signing key and add it:"
echo "  gpg --full-generate-key"
echo "  gpg --list-secret-keys --keyid-format=long"
echo "  gpg --armor --export YOUR_SIGNING_KEY"
echo "  git config --global user.signingkey YOUR_SIGNING_KEY"