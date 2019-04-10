#!/bin/bash
 # Program Filename: manjaro-postbuild-full-install-gnome-3.5.sh
 # Author: Christopher Pavlovich
 # Date: June 2018
 # Description: remove bloatware from manjaro basic installation, add my own

# not for distribution
wrkPath="./.postBuild/Manjaro/Server/.tmp"
# [[ -d $wrkPath ]] || mkdir -p $wrkPath
mkdir -p $wrkPath
runDefaults=1
errorsFound=1

# default option prevents the script from further prompts until final restart option

if [[ $1 == "default" ]]; then
	runDefaults=0
else
	# prompt and start build script
	read -p "Run script with defaults? [Y/n]: " -n 1 -r
	if [[ $REPLY =~ ^[Nn] ]]; then
		echo "nope" > /dev/null
	else
		runDefaults=0
	fi
fi

# pull fastest mirrors
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
if  [ $runDefaults -eq 0 ]; then
	sudo pacman -Rs manjaro-hello --noconfirm > "$wrkPath/logs"
	sudo pacman -Rs hexchat --noconfirm > "$wrkPath/logs"
	sudo pacman -Rs pidgin --noconfirm > "$wrkPath/logs"
	sudo pacman -Rs gufw --noconfirm > "$wrkPath/logs"
else
	sudo pacman -Rs manjaro-hello
	sudo pacman -Rs hexchat
	sudo pacman -Rs pidgin
	sudo pacman -Rs gufw
fi

# install my personal favorites
echo
echo "- Suggested Software Installs -"
echo
if [ $runDefaults -eq 0 ]; then # no prompt for input
	sudo pacman -S zsh --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S vim --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S terminator --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S git --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S gcc --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S clang --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S gdb --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S valgrind --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S nodejs --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S firewalld --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S openssh --needed --noconfirm > "$wrkPath/logs"
	sudo pacman -S deja-dup --needed --noconfirm > "$wrkPath/logs"
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

rm -rf $wrkPath

exit 0
