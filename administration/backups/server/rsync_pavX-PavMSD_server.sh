#!/bin/bash
# Chris Pavlovich
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-msd

read -p "Back up pav-x/backups and pav-x/storage to pav-msd? [Y/n]: " -n 1 -r && echo

if [[ $REPLY =~ ^[nN] ]]; then
	echo "Exiting script." # throw error and exit
	echo "Exit request received from user." >&2
	exit 1
else	# prep user list (space delimited)
	userList="$(cat /home/pro-admin/userList.psf)"
	read -p "Is pav-msd mounted on /home/drives/pav-msd/ ? [Y/n]: " -n 1 -r && echo
	if [[ $REPLY =~ ^[nN] ]]; then	# drive not mounted
		echo "Error: back up drive not mounted" # throw error and exit
		echo "Error: back up drive not mounted" >&2
		exit 1
	else 	# back up data from pav-x to pav-msd
		# use cp if rsync returns non-zero status
		rsync -avh /home/drives/pav-x/backups /home/drives/pav-msd/
		[ $? ] || cp -rvu /home/drives/pav-x/backups /home/drives/pav-msd/
		rsync -avh /home/drives/pav-x/master /home/drives/pav-msd/storage/
		[ $? ] || cp -rvu /home/drives/pav-x/master /home/drives/pav-msd/storage/
	fi
	echo
fi

echo "Complete. Errors (if any) will be listed above."

exit 0 || return 0
