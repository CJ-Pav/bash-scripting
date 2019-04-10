#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-xthd

read -p "Transfering select files from cjpavlov to pav-xthd (any key to continue): " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/cjpavlov to /run/media/cjpavlov/pav-xthd/backups/"

	echo "Copying bin-royale"
	cp -ru /home/cjpavlov/bin-royale /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Desktop"
	cp -ru /home/cjpavlov/Desktop /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Documents"
	cp -ru /home/cjpavlov/Documents /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Downloads"
	cp -rn /home/cjpavlov/Downloads /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Music"
	cp -rn /home/cjpavlov/Music /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying MyCode"
	cp -ru /home/cjpavlov/MyCode /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Pictures"
	cp -rn /home/cjpavlov/Pictures /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Programs/my_prog.txt"
	cp -ru /home/cjpavlov/Programs/my_prog.txt /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Public"
	cp -ru /home/cjpavlov/Public /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying Support"
	cp -rn /home/cjpavlov/Support /run/media/cjpavlov/pav-xthd/backups/royale
	cp -ru /home/cjpavlov/Support/help-documents /run/media/cjpavlov/pav-xthd/backups/royale/Support

	echo "Copying Videos"
	cp -rn /home/cjpavlov/Videos /run/media/cjpavlov/pav-xthd/backups/royale

	echo "Copying VirtualBox VMs"
	cp -rn /home/cjpavlov/VirtualBox\ VMs/*.ova /run/media/cjpavlov/pav-xthd/backups/royale

	mkdir /run/media/cjpavlov/pav-xthd/backups/royale/restore

	echo "Copying profiles for Vim, Firefox, and Thunderbird"
	cp -ru /home/cjpavlov/.config /run/media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.mozilla /run/media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.thunderbird /run/media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.vimrc /run/media/cjpavlov/pav-xthd/backups/royale/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
