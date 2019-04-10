#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Post install script for personal common packages.

sudo yum -y autoremove
sudo yum -y update
sudo yum -y upgrade

sudo yum -y install vim
sudo yum -y install htop
sudo yum -y install gcc
sudo yum -y install g++
sudo yum -y install clang
sudo yum -y install tlp
sudo yum -y install 

sudo yum -y autoremove

# ssh & firewalld enabled by default in CentOS 7
sudo systemctl enable tlp

# prompt for reboot
read -p "Restart system? [Y/n]: " -n 1 response
if [[ "$response" =~ ^[nN] ]]; then
    echo "Warn: restart to apply changes." >&2
    exit 1
fi

sudo reboot

exit 0
