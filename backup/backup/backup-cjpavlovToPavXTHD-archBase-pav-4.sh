#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-xthd

read -p "Make sure you are connected to the network drive (any key to continue) " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/cjpavlov to /run/media/cjpavlov/pav-xthd/backups/"

	echo " - Making sure royale exists to initialize file transfer... "
	echo "	 	(error message expected if folder exists)"
	mkdir /media/cjpavlov/pav-xthd/backups/royale

	echo "Copying bin-royale"
	cp -rvu /home/cjpavlov/bin* /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Desktop"
	cp -rvu /home/cjpavlov/Desktop /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Documents"
	cp -rvu /home/cjpavlov/Documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Downloads"
	cp -rvn /home/cjpavlov/Downloads /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Music"
	cp -rvn /home/cjpavlov/Music /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying code"
	cp -rvu /home/cjpavlov/code /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Pictures"
	cp -rvn /home/cjpavlov/Pictures /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Programs/my_prog.txt"
	cp -rvu /home/cjpavlov/programs/my_prog.txt /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Public"
	cp -rvu /home/cjpavlov/Public /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying Support"
	cp -rvn /home/cjpavlov/support /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale
	cp -rvu /home/cjpavlov/support/help-documents /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/Support

	echo "Copying Videos"
	cp -rvn /home/cjpavlov/Videos /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	echo "Copying VirtualBox VMs"
	cp -rvn /home/cjpavlov/VirtualBox\ VMs/*.ova /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale

	mkdir /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore

	echo "Copying profiles for Vim, Firefox, and Thunderbird"
	cp -rvu /home/cjpavlov/.config /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu /home/cjpavlov/.mozilla /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu /home/cjpavlov/.thunderbird /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/
	cp -rvu /home/cjpavlov/.vimrc /run/user/1000/gvfs/smb-share\:server\=hell0w0rld\,share\=pav-xthd/backups/royale/restore/


	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
