#!/bin/bash
# Chris Pavlovich
# July 06 2018 at 00:35:47 AM
# Back up ghost directories to pav-xthd

read -p "Make sure you are connected to the phone (any key to continue) " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "If an error thrown following this line, ignore it!"
	sudo mkdir -p /home/holding/ghost/card

	echo
	echo "Starting file transfer from /home/cjpavlov to /run/media/cjpavlov/pav-xthd/backups/"

	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/DCIM /home/holding/ghost/card/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Documents /home/holding/ghost/card/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Downloads /home/holding/ghost/card/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Card/Lolz /home/holding/ghost/card/

	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/DCIM /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/polarisOffice5 /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Documents /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Movies /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/PENUP /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Ringtones /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Slack /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Sounds /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/CamScanner /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Download /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Music /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Pictures /home/holding/ghost/phone/
	cp -rvn /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/Telegram /home/holding/ghost/phone/
	cp -rvu /run/user/1000/gvfs/mtp\:host\=%5Busb%3A001%2C016%5D/Phone/My\ Documents /home/holding/ghost/phone/

	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
