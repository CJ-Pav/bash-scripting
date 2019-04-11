#!/bin/bash
# Mint post install script: basic software packages

echo
# Updates...
sudo apt update -y
sudo apt upgrade -y

echo
# Ensure essential installs...
sudo apt install -y vim
sudo apt install -y filezilla
sudo apt install -y gcc
sudo apt install -y g++
sudo apt install -y clang
sudo apt install -y firewalld
sudo apt install -y tlp
sudo apt install -y sshd
sudo apt install -y terminator

echo
# Remove excess pkgs...
sudo apt remove -y gufw
sudo apt remove -y bluez
sudo apt remove -y bluetooth
sudo apt remove -y flashplayer
sudo apt remove -y camera-app
sudo apt remove -y conky
sudo apt remove -y cups
sudo apt remove -y chromium

sudo apt autoremove -y


echo
# Clearing caches..."

sudo apt clean metadata

echo
echo "Complete. A system reboot is recommended."

echo
