#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-1.sh
 # Author: Christopher Pavlovich
 # Date: May 2018
 # Description: remove bloatware from manjaro basic installation, add my own

read -p "Running manjaro-postbuild-full-install-1.sh" -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo
	echo "Updates..."
	sudo pacman -Syu -y

	echo
	echo "Installs..."
	sudo pacman -S yaourt
	sudo pacman -S vim
	sudo pacman -S terminator
	sudo pacman -S redshift
	sudo pacman -S deja-dup
	sudo pacman -S firewalld
	sudo pacman -S sshd
	yaourt -S atom

	echo
	echo "Trimming the fat..."
	sudo pacman -Rs hexchat -y
	sudo pacman -Rs pamac -y
	sudo pacman -Rs audacious -y
	sudo pacman -Rs steam-manjaro -y

	echo
	echo "Enable power saver and firewall..."
	sudo systemctl enable firewalld
	sudo systemctl enable tlp
	# sudo systemctl enable sshd

	echo
	echo "Applying changes will require full system restart."

	# sudo reboot

fi
