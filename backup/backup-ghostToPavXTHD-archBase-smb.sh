#!/bin/bash
# Chris Pavlovich
# July 06 2018 at 00:35:47 AM
# Back up ghost directories to pav-xthd

read -p "Make sure you are connected to the phone (any key to continue) " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer from /home/cjpavlov to /run/media/cjpavlov/pav-xthd/backups/"

	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/DCIM /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/card/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Documents /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/card/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Downloads /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/card/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Lolz /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/card/

	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/DCIM /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/polarisOffice5 /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Documents /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Movies /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/PENUP /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Ringtones /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Slack /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Sounds /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/CamScanner /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Download /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Music /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Pictures /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Telegram /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/My\ Documents /run/user/1000/gvfs/smb-share:server=hell0w0rld,share=pav-xthd/backups/ghost/phone/

	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
