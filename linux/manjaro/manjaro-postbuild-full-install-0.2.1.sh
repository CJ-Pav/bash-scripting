#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-0.1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: remove bloatware from manjaro basic installation, add my own

read -p "Running manjaro-postbuild-full-install-1.sh" -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Updates..."
	sudo pacman -Syu

	# echo "Installs..."
	# sudo pacman -S firewalld

	echo "Trimming the fat..."
	sudo pacman -Rs manjaro-hello
	# sudo pacman -Rs hexchat
	# sudo pacman -Rs steam-manjaro
	# sudo pacman -Rs pidgin
	# sudo pacman -Rs gufw

	# echo "Services..."
	# sudo systemctl enable tlp
	# sudo systemctl enable firewalld

	# sudo reboot

fi
