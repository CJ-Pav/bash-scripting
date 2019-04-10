#!/bin/bash
# MX post install script: basic software packages

printf "\n - Updates...\n"
sudo apt update -y
sudo apt upgrade -y

printf "\n - Installs...\n"
sudo apt install -y vim
sudo apt install -y filezilla
sudo apt install -y atom
sudo apt install -y gcc
sudo apt install -y g++
sudo apt install -y clang
sudo apt install -y firewalld
sudo apt install -y git
sudo apt install -y nodejs
sudo apt install -y npm

printf "\n - Remove excess pkgs...\n"
sudo apt remove -y gufw
sudo apt remove -y conky-all
sudo apt autoremove -y

printf "\n - Clearing caches...\n"
sudo apt clean metadata

printf "\nComplete\n\n"

exit 0
