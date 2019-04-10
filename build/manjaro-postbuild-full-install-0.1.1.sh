#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-1.1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: should be run after manjaro-postbuild-full-install-0.1.sh

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

fi
