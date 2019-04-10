#!/bin/bash -e
# Program Filename: docker-install.sh
# Author: Chris Pavlovich
# Date: Nov 25, 2018
# Description: install, start, enable,
#       and add user to docker

# install docker
sudo pacman -S docker

# start & enable docker
sudo systemctl start docker
sudo systemctl enable docker

# add user to docker group
sudo usermod -aG docker $USER
