#!/bin/bash

response=""
_status_=0

while [[ ! "$response" =~ ^[Nn] ]]; do

	lsblk
	read -p "Mount a drive? (/dev/sd?/sd?#) [Y/n]: " -n 1 _response_
	if [[ "$response" =~ ^[nN] ]]; then
		# complement and exit
		echo "Exiting, you're a beautiful human being."
	else
		# gather drive info
		read -p "Please enter a drive name to mount? (Eg. \"/dev/sd?#\"): " _partitionName_
		read -p "Please enter a path for the mount point (Eg. \"/mnt/my_drive/\"): " _mountLocation_
		# read -p "Please enter a the drive partition type (leave blank if unsure): " _partitionType_

		# prompt for confirmation
		read -p "Mount \"$_partitionName_\" on \"$_mountLocation_?\" [Y/n]: " -n 1 -r

		# bail or mount drive
		if [[ "$REPLY" =~ ^[nN] ]]; then
			# insult and exit
			echo "Canceled drive mount."
			_status_=1
		else
			# attempt drive mount
			# if [[ -z "$_partitionType_" ]]; then
				sudo mount $_partitonName_ $_mountLocation_
				_status_=$?
			# else
			# 	sudo $(mount -t $_partitionType_ $_partitonName_ $_mountLocation_)
			# 	_status_=$?
			# fi
			# warn if errors
			if [ $_status_ -ne 0 ]; then
				echo "Warning: detected issue with mount, read previous outputs." >&2
				_status_=2
			fi
		fi
	fi
done

return $_status_ || exit $_status_
