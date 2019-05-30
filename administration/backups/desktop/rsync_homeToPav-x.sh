#!/bin/bash -e

# Chris Pavlovich1
# May 14 2018 at 01:25:05 AM
# Back up home directories to pav-x

read -p "Back up home directory to pav-x? [Y/n]: " -n 1 -r
if [[ $REPLY =~ ^[nN] ]]; then
	echo "Exiting script."
	echo "back up drive not mounted" >&2
	exit 1
else
	# prep users
	userList="cjpavlov erica adambartlett emre kyle pav-admin"

	# if drive not mounted, exit
	read -p "Is pav-x mounted on /home/drives/pav-x/ ? [Y/n]: " -n 1 -r
	if [[ $REPLY =~ ^[nN] ]]; then
		echo "Exiting script."
		echo "back up drive not mounted" >&2
		exit 1
	else
		# iterate through users and back up data from ssd
		for username in $userList; do
			# check destination. If DNE, make dest
			if [ -d "/home/drives/pav-x/backups/$username"]; then
				sudo mkdir "/home/drives/pav-x/backups/$username"
			else
				echo "Error, dir /home/$username DNE."
				echo "Directory /home/$username does not exist." >&2
			fi

			echo -e "Backing up /home/$username"

			echo "Starting file transfer from home directory to pav-x"
			echo "Copying bin-royale"
			sudo rsync -av /home/$username/bin*/* /home/drives/pav-x/backups/royale/bin/

			echo "Copying Desktop"
			sudo rsync -av /home/$username/Desktop /home/drives/pav-x/backups/royale

			echo "Copying Documents"
			sudo rsync -av /home/$username/Documents /home/drives/pav-x/backups/royale

			echo "Copying Downloads"
			sudo rsync -av /home/$username/Downloads /home/drives/pav-x/backups/royale

			echo "Copying Music"
			sudo rsync -av /home/$username/Music /home/drives/pav-x/backups/royale

			echo "Copying code"
			sudo rsync -av /home/$username/code /home/drives/pav-x/backups/royale

			echo "Copying Pictures"
			sudo rsync -av /home/$username/Pictures /home/drives/pav-x/backups/royale

			if [ -d /home/$username/support/logs/ ]; then
				echo "Copying /usr/bin"
				ls /usr/bin/ > /home/$username/support/logs/._my_prog.txt
				sudo rsync -av /home/$username/support/logs/._my_prog.txt /home/drives/pav-x/backups/royale/restore/
			else
				echo "Dir /home/$username/support/logs/ not found."
				echo "Error Dir /home/$username/support/logs/ not found." >&2
			fi

			echo "Copying Public"
			sudo rsync -av /home/$username/Public /home/drives/pav-x/backups/royale

			echo "Copying support"
			sudo rsync -av /home/$username/support /home/drives/pav-x/backups/royale
			sudo rsync -av /home/$username/support/HelpDocuments /home/drives/pav-x/backups/royale/Support

			echo "Copying Videos"
			sudo rsync -av /home/$username/Videos /home/drives/pav-x/backups/royale

			sudo mkdir /home/drives/pav-x/backups/royale/restore

			echo "Copying profiles for Vim, Firefox, and Thunderbird"
			sudo rsync -av /home/$username/.vimrc /home/drives/pav-x/backups/royale/restore/
			sudo rsync -av /home/$username/.mozilla /home/drives/pav-x/backups/royale/restore/
			sudo rsync -av /home/$username/.thunderbird /home/drives/pav-x/backups/royale/restore/
			sudo rsync -av /home/$username/.zshrc /home/drives/pav-x/backups/royale/restore/

			echo "Syncing data..."
			sync

			echo "Transfer complete!"

		done
	fi
	exit 0
	echo
fi
