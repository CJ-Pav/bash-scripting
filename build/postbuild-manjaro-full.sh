#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-gnome-3.5.sh
 # Author: Christopher Pavlovich
 # Date: June 2018
 # Description: remove bloatware from manjaro basic installation, add my own

# not for distribution

# prompt and start build script
echo
read -p "Running manjaro-postbuild-full-install-1.sh (any key to continue)" -n 1 -r
if [[ ! -e "$REPLY" ]]
then
	echo
	
	# grab fastest mirrors
	sudo pacman-mirrors --fasttrack
	
	# run updates
	sudo pacman -Syu

	# install my personal favorites
	echo; echo "Software installs..."
	sudo pacman -S yaourt
	sudo pacman -S vim
	sudo pacman -S gcc
	sudo pacman -S clang
	sudo pacman -S nodejs
	sudo pacman -S terminator
	sudo pacman -S firewalld
	sudo pacman -S sshd
	sudo pacman -S redshift
	sudo pacman -S deja-dup
	yaourt -S atom
	yaourt -S spotify


	# remove unnessary software
	echo; echo "Remove bloatware..."
	sudo pacman -Rs hexchat
	sudo pacman -Rs pamac
	sudo pacman -Rs audacious
	sudo pacman -Rs steam-manjaro
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
	sudo pacman -Rs manjaro-hello

	# enable essentials
	echo; echo "Enabling services..."
	sudo systemctl enable tlp
	sudo systemctl enable firewalld
	sudo systemctl enable sshd

	# confirm updates with yaourt
	echo; echo "One more sweep..."
	yaourt -Syua

	# prompt and reboot to apply changes
	echo
	read -p "Restart to apply changes? [Y/n]" -r
	if [[ $REPLY =~ ^[Yy] ]]; then
		sudo reboot
	fi
fi
