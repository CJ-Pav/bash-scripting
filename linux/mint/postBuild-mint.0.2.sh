#!/bin/bash
# Mint post install script: basic software packages

# Updates...
sudo apt update -y
sudo apt upgrade -y

echo
# Ensure essential installs...
sudo apt install -y vim
sudo apt install -y filezilla
sudo apt install -y firewalld
sudo apt install -y tlp
sudo apt install -y sshd
sudo apt install -y terminator

echo
# Remove excess pkgs...
sudo apt remove -y gufw
sudo apt remove -y flashplayer
sudo apt remove -y camera-app
sudo apt remove -y evolution
# sudo apt remove -y

sudo apt autoremove -y

echo
# Clearing caches..."

sudo apt clean metadata

echo "Install script complete..." > ~/postInstallNotes.txt

sudo reboot

echo
