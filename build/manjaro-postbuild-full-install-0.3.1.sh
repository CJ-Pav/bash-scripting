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

	echo "Power management..."
	sudo systemctl enable tlp

	echo "Installs..."
	# sudo pacman -S firewalld
	# sudo pacman -S yaourt
	# sudo pacman -S vim
	# sudo pacman -S terminator
	# sudo pacman -S redshift
	# sudo pacman -S deja-dup

	echo "Trimming the fat..."
	sudo pacman -Rs manjaro-hello

	sudo reboot

fi
