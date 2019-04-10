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
	sudo pacman -Syu -y
	
	echo "Installs..."
	yaourt -S atom -y

	echo "Trimming the fat..."
	sudo pacman -Rs hexchat -y
	sudo pacman -Rs pamac -y
	sudo pacman -Rs audacious -y
	sudo pacman -Rs steam-manjaro -y

	echo "Reboot suggested"
	
	# sudo reboot

fi
