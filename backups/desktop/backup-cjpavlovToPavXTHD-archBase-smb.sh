#!/bin/bash
# Chris Pavlovich
# July 06 2018 at 00:35:47 AM
# Back up home directories to pav-xthd

read -p "Make sure you are connected to the network drive (any key to continue) " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from ~ to /run/media/cjpavlov/pav-xthd/backups/"

	echo " - Making sure royale exists to initialize file transfer... "
	echo "	 	(error message expected if folder exists)"
	mkdir /media/cjpavlov/pav-xthd/backups/royale

	echo "Copying bin-royale"
	cp -rvu ~/bin* /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Desktop"
	cp -rvu ~/Desktop /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Documents"
	cp -rvu ~/Documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Downloads"
	cp -rvn ~/Downloads /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Music"
	cp -rvn ~/Music /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying code"
	cp -rvu ~/code /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Pictures"
	cp -rvn ~/Pictures /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying programs/my_prog.txt"
	cp -rvu ~/programs/my_prog.txt /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Public"
	cp -rvu ~/Public /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying support"
	cp -rvn ~/support /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale
	cp -rvu ~/support/help-documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/Support

	echo "Copying Videos"
	cp -rvn ~/Videos /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying VirtualBox VMs"
	cp -rvn ~/VirtualBox\ VMs/*.ova /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	mkdir /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore

	echo "Copying profiles for Vim, Firefox, and Thunderbird"
	cp -rvu ~/.config /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu ~/.mozilla /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu ~/.thunderbird /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu ~/.vimrc /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
