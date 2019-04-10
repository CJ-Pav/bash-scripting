#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: remove bloatware from manjaro basic installation, add my own

read -p "Running manjaro-postbuild-full-install-1.sh" -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Updates..."
	sudo pacman -Syu

	echo "Installs..."
	yaourt -S atom

	echo "Trimming the fat..."
	sudo pacman -Rs hexchat
	sudo pacman -Rs pamac
	sudo pacman -Rs audacious
	sudo pacman -Rs steam-manjaro

	echo "Reboot suggested"

	# sudo reboot

fi
