#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-0.1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: remove bloatware from manjaro basic installation, add my own

# prompt and start build script
echo
read -p "Running manjaro-postbuild-full-install-1.sh (any key to continue)" -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	# run updates
	echo
	echo "Updates..."
	sudo pacman -Syu

	# install my personal favorites
	echo
	echo "Building system..."
	sudo pacman -S yaourt
	sudo pacman -S vim
	sudo pacman -S terminator
	sudo pacman -S redshift
	sudo pacman -S deja-dup
	sudo pacman -S firewalld
	sudo pacman -S sshd
	yaourt -S atom

	# remove unnessary software
	echo
	echo "Trimming the fat..."
	sudo pacman -Rs hexchat -y
	sudo pacman -Rs pamac -y
	sudo pacman -Rs audacious -y
	sudo pacman -Rs steam-manjaro -y
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
	sudo pacman -Rs manjaro-hello

	# enable essentials
	echo
	echo "Enabling services..."
	sudo systemctl enable tlp
	sudo systemctl enable firewalld
	sudo systemctl enable sshd

	# prompt and reboot to apply changes
	echo
	read -p "Restarting to apply updates (any key to continue)" -r
	if [[ ! $REPLY =~ ^{Yy]$ ]]
	then
		sudo reboot
	fi

fi
