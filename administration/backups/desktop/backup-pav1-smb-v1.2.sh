#!/bin/bash
# Chris Pavlovich
# July 06 2018 at 00:35:47 AM
# Back up home directories to pav-xthd

read -p "Make sure you are connected to the network drive (any key to continue) " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/cjpavlov to /run/media/cjpavlov/pav-xthd/backups/"

	echo " - Making sure royale exists to initialize file transfer... "
	echo "	 	(error message expected if folder exists)"
	mkdir /media/cjpavlov/pav-xthd/backups/pav-1

	echo "Copying bin-royale"
	cp -rvu /home/cjpavlov/bin* /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Desktop"
	cp -rvu /home/cjpavlov/Desktop /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Documents"
	cp -rvu /home/cjpavlov/Documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Downloads"
	cp -rvn /home/cjpavlov/Downloads /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Music"
	cp -rvn /home/cjpavlov/Music /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying code"
	cp -rvu /home/cjpavlov/code /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Pictures"
	cp -rvn /home/cjpavlov/Pictures /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying programs/my_prog.txt"
	cp -rvu /home/cjpavlov/programs/my_prog.txt /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying Public"
	cp -rvu /home/cjpavlov/Public /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying support"
	cp -rvn /home/cjpavlov/support /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1
	cp -rvu /home/cjpavlov/support/help-documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/Support

	echo "Copying Videos"
	cp -rvn /home/cjpavlov/Videos /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	echo "Copying VirtualBox VMs"
	cp -rvn /home/cjpavlov/VirtualBox\ VMs/*.ova /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1

	mkdir /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/restore

	echo "Copying profiles for Vim, Firefox, and Thunderbird"
	cp -rvu /home/cjpavlov/.config /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/restore/
	cp -rvu /home/cjpavlov/.mozilla /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/restore/
	cp -rvu /home/cjpavlov/.thunderbird /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/restore/
	cp -rvu /home/cjpavlov/.vimrc /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/pav-1/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
