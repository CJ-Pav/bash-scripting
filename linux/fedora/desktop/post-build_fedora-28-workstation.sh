#!/bin/bash
# Post install script for personal common packages.

sudo dnf -y install vim
sudo dnf -y install htop
sudo dnf -y install gcc
sudo dnf -y install clang
sudo dnf -y install firewalld
sudo dnf -y install tlp
sudo dnf -y install sshd
sudo dnf -y install gdb
sudo dnf -y install imagemagick
sudo dnf -y install snap
sudo dnf -y install chromium
sudo dnf -y install gedit
sudo dnf -y install filezilla

sudo dnf -y autoremove

sudo systemctl enable sshd
sudo systemctl enable tlp
sudo systemctl enable firewalld

sudo reboot

echo "Complete"
echo
