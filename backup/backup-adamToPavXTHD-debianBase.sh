#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-xthd

read -p "Transfering select files from adam-bartlett to pav-xthd (any key to continue): " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/adam-bartlett to /media/adam-bartlett/pav-xthd/backups/"

	mkdir /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying bin-mr-noodle"
	cp -ru /home/adam-bartlett/bin-* /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Desktop"
	cp -ru /home/adam-bartlett/Desktop /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Documents"
	cp -ru /home/adam-bartlett/Documents /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Downloads"
	cp -rn /home/adam-bartlett/Downloads /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Music"
	cp -rn /home/adam-bartlett/Music /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Pictures"
	cp -rn /home/adam-bartlett/Pictures /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Programs/*.txt"
	cp -ru /home/adam-bartlett/programs/*.txt /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Public"
	cp -ru /home/adam-bartlett/Public /media/adam-bartlett/pav-xthd/backups/mr-noodle

	echo " - Copying Videos"
	cp -rn /home/adam-bartlett/Videos /media/adam-bartlett/pav-xthd/backups/mr-noodle

	mkdir /media/adam-bartlett/pav-xthd/backups/mr-noodle/restore

	echo " - Copying profiles for Vim, Firefox, and Thunderbird"
	cp -ru /home/adam-bartlett/.config /media/adam-bartlett/pav-xthd/backups/mr-noodle/restore/
	cp -ru /home/adam-bartlett/.mozilla /media/adam-bartlett/pav-xthd/backups/mr-noodle/restore/
	cp -ru /home/adam-bartlett/.thunderbird /media/adam-bartlett/pav-xthd/backups/mr-noodle/restore/
	cp -ru /home/adam-bartlett/.vimrc /media/adam-bartlett/pav-xthd/backups/mr-noodle/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
