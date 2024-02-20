#!/bin/bash

sudo apt install -y software-properties-common

sudo add-apt-repository -y -S 'deb https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main'

sudo apt update
sudo apt install -y python3.12
