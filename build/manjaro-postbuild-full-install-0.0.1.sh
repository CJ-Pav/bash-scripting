#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-0.1.sh
 # Author: Christopher Pavlovich
 # Edited: Feb 15, 2019
 # Description: remove bloatware from manjaro basic installation, add my own

 echo "Running manjaro-postbuild-full-install"

read -p "Continue? [Y/n]: " -r

if [[ "$REPLY" =~ ^[nN] ]]
	echo "Updates..."
	sudo pacman -Syu

	echo "Power management..."
	sudo systemctl enable tlp

	echo "Installs..."
	sudo pacman -S yaourt
	sudo pacman -S vim
	sudo pacman -S terminator
	sudo pacman -S redshift
	sudo pacman -S deja-dup

	echo "Trimming the fat..."
	sudo pacman -Rs hexchat
	sudo pacman -Rs pamac
	sudo pacman -Rs audacious
	sudo pacman -Rs steam-manjaro

	sudo reboot
fi
