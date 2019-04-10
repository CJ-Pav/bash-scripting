#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-gnome-3.5.sh
 # Author: Christopher Pavlovich
 # Date: June 2018
 # Description: remove bloatware from manjaro basic installation, add my own

# not for distribution

# prompt and start build script
echo
read -p "Running manjaro-postbuild-full-install-1.sh (any key to continue)" -n 1 -r
if [[ ! $REPLY =~ ^[Yy] ]]
then
	# run updates
	sudo pacman-mirrors --fasttrack
	sudo pacman -Syu

	# install my personal favorites
	sudo pacman -S yaourt --noconfirm --needed
	sudo pacman -S vim --noconfirm --needed
	sudo pacman -S gcc --noconfirm --needed
	sudo pacman -S clang --noconfirm --needed
	sudo pacman -S nodejs --noconfirm --needed
	sudo pacman -S terminator --noconfirm --needed
	sudo pacman -S firewalld --noconfirm --needed
	sudo pacman -S sshd --noconfirm --needed
	sudo pacman -S redshift --noconfirm --needed
	sudo pacman -S deja-dup --noconfirm --needed
	sudo pacman -S file-roller --noconfirm --needed
	sudo pacman -S gedit --noconfirm --needed
	sudo pacman -S transmission-gtk --noconfirm --needed
	sudo pacman -S thunderbird --noconfirm --needed
	sudo pacman -S filezilla --noconfirm --needed
	sudo pacman -S git --noconfirm --needed
	# sudo pacman -S 

	# gnome software
	# sudo pacman -S gdm --noconfirm --needed
	# echo "Some of these will probably fail (it's ok)"
	# sudo pacman -S gdm-dev --noconfirm --needed
	# sudo pacman -S gnome-session --noconfirm --needed
	# sudo pacman -S gnome-keyring --noconfirm --needed
	# sudo pacman -S gnome-settings-daemon --noconfirm --needed
	# sudo pacman -S gnome-logs --noconfirm --needed
	# sudo pacman -S gnome-shell --noconfirm --needed
	# sudo pacman -S gnome-disk-utility --noconfirm --needed
	# sudo pacman -S gnome-tweak-tool --noconfirm --needed
	# sudo pacman -S gnome-backgrounds --noconfirm --needed
	# sudo pacman -S gnome-menus --noconfirm --needed
	# sudo pacman -S gnome-dictionary --noconfirm --needed
	# sudo pacman -S gnome-themes-extra --noconfirm --needed
	# sudo pacman -S gnome-maps --noconfirm --needed
	# sudo pacman -S gnome --noconfirm --needed
	# sudo pacman -S gnome --noconfirm --needed#


	# AUR software
	yaourt -S atom --noconfirm --needed
	yaourt -S spotify --noconfirm --needed


	# remove unnessary software
	sudo pacman -Rs hexchat -y
	sudo pacman -Rs pamac -y
	sudo pacman -Rs audacious -y
	sudo pacman -Rs steam-manjaro -y
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
	sudo pacman -Rs manjaro-hello
	sudo pacman -Rs ms-office-online

	# enable essentials
	echo
	echo "Enabling services..."
	sudo systemctl enable tlp
	sudo systemctl enable firewalld
	sudo systemctl enable sshd

	# confirm updates with yaourt
	echo
	echo "One more sweep..."
	yaourt -Syua

	# prompt and reboot to apply changes
	echo
	read -p "Restarting to apply updates (any key to continue)" -r
	if [[ ! $REPLY =~ ^{Yy]$ ]]
	then
		sudo reboot
	fi
fi
