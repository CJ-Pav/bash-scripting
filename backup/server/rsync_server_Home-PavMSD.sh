#!/bin/bash -e

# Chris Pavlovich1
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-msd

read -p "Back up home directory to pav-msd? [Y/n]: " -n 1 -r

if [[ $REPLY =~ ^[nN] ]]; then
	echo "Exiting script." # throw error and exit
	echo "Exit request received from user." >&2
	exit 1
else
	# prep user list (space delimited)
	userList="$(cat /home/pro-admin/userList.psf)"

	# if drive not mounted, exit
	read -p "Is pav-msd mounted on /home/drives/pav-msd/ ? [Y/n]: " -n 1 -r
	if [[ $REPLY =~ ^[nN] ]]; then
		echo "Exiting script." # throw error and exit
		echo "back up drive not mounted" >&2
		exit 1
	else
		# iterate through users and back up data from ssd
		for username in $userList; do
			# check destination
			if [ -d "/home/drives/pav-msd/backups/$username" ]; then
				# if exists, store contents
				echo -e "Backing up /home/$username"
			else
				# create if DNE
				sudo mkdir "/home/drives/pav-msd/backups/$username"
				echo -e "Backing up /home/$username"
			fi

			contents="$(ls /home/$username)"

			for dir in contents; do
				# back up each home directory sub-directory into backup home directories
				sudo rsync -avh /home/$username/$dir /home/drives/pav-msd/backups/users/$username/

			done

			# back up config files
			sudo mkdir /home/drives/pav-msd/backups/$username/restore
			sudo rsync -av /home/$username/.vimrc /home/drives/pav-msd/backups/$username/restore/
			sudo rsync -av /home/$username/.mozilla /home/drives/pav-msd/backups/$username/restore/
			sudo rsync -av /home/$username/.thunderbird /home/drives/pav-msd/backups/$username/restore/
			sudo rsync -av /home/$username/.zshrc /home/drives/pav-msd/backups/$username/restore/

			echo "Syncing data..."
			sync

			echo "Transfer complete!"

		done
	fi
	exit 0
	echo
fi
