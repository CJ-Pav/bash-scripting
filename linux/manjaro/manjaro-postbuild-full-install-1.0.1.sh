#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-0.1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: remove bloatware from manjaro basic installation, add my own

read -p "Running manjaro-postbuild-full-install-1.sh" -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]

	echo "Updates..."
	sudo pacman -Syu

	echo "Installs..."
	sudo pacman -S yaourt
	sudo pacman -S vim
	sudo pacman -S terminator
	sudo pacman -S redshift
	sudo pacman -S deja-dup
	sudo pacman -S firewalld
	yaourt -S atom


	echo "Trimming the fat..."
	sudo pacman -Rs hexchat
	sudo pacman -Rs pamac
	sudo pacman -Rs audacious
	sudo pacman -Rs steam-manjaro
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
	sudo pacman -Rs manjaro-hello

	echo "Services..."
	sudo systemctl enable tlp
	# sudo systemctl enable sshd
	sudo systemctl enable firewalld

	sudo reboot

fi
