#!/bin/bash
# MX post install script: basic software packages


echo
echo " - Updates..."
sudo apt update -y
sudo apt upgrade -y

echo
echo " - Installs..."
sudo apt install -y vim
sudo apt install -y filezilla
sudo apt install -y atom
sudo apt install -y gcc
sudo apt install -y g++
sudo apt install -y clang
sudo apt install -y firewalld

echo
echo " - Remove excess pkgs..."
sudo apt remove -y gufw
sudo apt remove -y conky-all
sudo apt autoremove -y

echo
echo " - Clearing caches..."
sudo apt clean metadata

echo
read -p "A recommended patch for this script exists, run it? [Y/n]" -n 1 -r
[[ $REPLY =~ ^[nN] ]] || sudo ./postBuild-mx-1.2.sh

echo
read -p "Complete. Would you like to restart the computer? [Y/n]" -n 1 -r
[[ $REPLY =~ ^[nN] ]] || sudo reboot

exit 0
