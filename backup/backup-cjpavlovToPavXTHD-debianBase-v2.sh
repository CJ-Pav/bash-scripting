#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-xthd

read -p "Transfering select files from cjpavlov to pav-xthd (any key to continue): " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/cjpavlov to /media/cjpavlov/pav-xthd/backups/"

	echo " - Copying old backup to /media/cjpavlov/pav-xthd/master/"
	cp -rn /media/cjpavlov/pav-xthd/backups/royale/* /media/cjpavlov/pav-xthd/master/

	echo " - Making sure royale exists to initialize file transfer... "
	echo "	 	(error message expected if folder exists)"
	mkdir /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying local bin"
	cp -ru /home/cjpavlov/bin-* /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying code"
	cp -ru /home/cjpavlov/code /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Desktop"
	cp -ru /home/cjpavlov/Desktop /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Documents"
	cp -ru /home/cjpavlov/Documents /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Downloads"
	cp -rn /home/cjpavlov/Downloads /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Music"
	cp -rn /home/cjpavlov/Music /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Pictures"
	cp -rn /home/cjpavlov/Pictures /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying programs/*.txt"
	cp -ru /home/cjpavlov/programs/*.txt /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying Public"
	cp -ru /home/cjpavlov/Public /media/cjpavlov/pav-xthd/backups/royale

	echo " - Copying support"
	cp -rn /home/cjpavlov/support /media/cjpavlov/pav-xthd/backups/royale
	cp -ru /home/cjpavlov/support/help* /media/cjpavlov/pav-xthd/backups/royale/support/

	echo " - Copying Videos"
	cp -rn /home/cjpavlov/Videos /media/cjpavlov/pav-xthd/backups/royale

	mkdir /media/cjpavlov/pav-xthd/backups/royale/restore

	echo " - Copying profiles for Vim, Firefox, and Thunderbird"
	cp -ru /home/cjpavlov/.config /media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.mozilla /media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.thunderbird /media/cjpavlov/pav-xthd/backups/royale/restore/
	cp -ru /home/cjpavlov/.vimrc /media/cjpavlov/pav-xthd/backups/royale/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
