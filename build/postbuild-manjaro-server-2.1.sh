#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-gnome-3.5.sh
 # Author: Christopher Pavlovich
 # Date: June 2018
 # Description: remove bloatware from manjaro basic installation, add my own

# not for distribution
___wrkPath___="./.postBuild/Manjaro/Server/.tmp"
# [[ -d $___wrkPath___ ]] || mkdir -p $___wrkPath___
mkdir -p $___wrkPath___
___runDefaults___=1
___errFnd___=1

if [[ $1 == "default" ]]; then
	___runDefaults___=0
else
	# prompt and start build script
	read -p "Run script with defaults? [Y/n]: " -n 1 -r
	if [[ $REPLY =~ ^[Nn] ]]; then
		echo "nope" > /dev/null
	else
		___runDefaults___=0
	fi
fi

# pull fastest mirrors
echo; echo "- Pulling Fastest Mirrors - "; echo
sudo pacman-mirrors --fasttrack

# takes a sec to free lock on pacman
for (( i=0; i<1000; i++ )); do
	echo "filler line $i" > /dev/null
done

# run updates
sudo pacman -Syyu

# remove unnessary software
echo
echo "- Suggested Software Removal -"
echo
if  [ $___runDefaults___ -eq 0 ]; then
	sudo pacman -Rs manjaro-hello --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs hexchat --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs steam-manjaro --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs pidgin --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs gufw --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs pamac --noconfirm > "$___wrkPath___/logs"
	sudo pacman -Rs audacious --noconfirm > "$___wrkPath___/logs"
else
	sudo pacman -Rs manjaro-hello
	sudo pacman -Rs hexchat
	sudo pacman -Rs steam-manjaro
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
	sudo pacman -Rs pamac
	sudo pacman -Rs audacious
fi

# install my personal favorites
echo
echo "- Suggested Software Installs -"
echo
if [ $___runDefaults___ -eq 0 ]; then # no prompt for input
	sudo pacman -S zsh --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S vim --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S terminator --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S git --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S gcc --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S clang --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S gdb --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S valgrind --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S nodejs --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S firewalld --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S openssh --needed --noconfirm > "$___wrkPath___/logs"
	sudo pacman -S deja-dup --needed --noconfirm > "$___wrkPath___/logs"
else
	sudo pacman -S zsh --needed
	sudo pacman -S vim --needed
	sudo pacman -S terminator --needed
	sudo pacman -S git --needed
	sudo pacman -S gcc --needed
	sudo pacman -S clang --needed
	sudo pacman -S gdb --needed
	sudo pacman -S valgrind --needed
	sudo pacman -S nodejs --needed
	sudo pacman -S firewalld --needed
	sudo pacman -S openssh --needed
	sudo pacman -S deja-dup --needed
fi

# enable essentials
echo
echo "Enabling services..."
echo
sudo systemctl enable tlp
sudo systemctl enable firewalld
sudo systemctl enable sshd

# confirm updates with yaourt
echo
echo "One more sweep for updates..."
echo
pacman -Syyu

# prompt and reboot to apply changes
echo
read -p "Restart to apply changes? [Y/n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo reboot
fi

rm -rf $___wrkPath___

exit 0
