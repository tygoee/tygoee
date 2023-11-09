#!/bin/bash

# -- Setup rclone -- #
# Make the directory
mkdir ~/OneDrive

# Configure rclone
rclone config #- Fill in everything (needs GUI)

# Create the systemd service
echo "[Unit]
Description=rclone mount
After=network-online.target

[Service]
User=$(whoami)
ExecStartPre=/bin/sleep 10
ExecStart=/usr/bin/rclone --vfs-cache-mode writes --dir-cache-time 10s mount \"OneDrive:\" $HOME/OneDrive

[Install]
WantedBy=default.target" | sudo tee /etc/systemd/system/rclone.service

# Reload and enable the systemd service
sudo systemctl daemon-reload
sudo systemctl enable rclone.service
sudo systemctl start rclone.service

# -- Setup Git -- #
# Read the username and email
echo -n "Git username: "
read -r git_user

echo -n "Git email: "
read -r git_email

# Set them
git config --global user.name "$git_user"
git config --global user.email "$git_email"
git config --global commit.gpgsign true

# Instruct user to create a signing key
echo "Make sure to create a signing key and add it:"
echo "  gpg --full-generate-key"
echo "  gpg --list-secret-keys --keyid-format=long"
echo "  gpg --armor --export YOUR_SIGNING_KEY"
echo "  git config --global user.signingkey YOUR_SIGNING_KEY"