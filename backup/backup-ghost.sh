#!/bin/bash
# Chris Pavlovich
# June 12, 2018 at 01:25:05 AM
# Back up home directories to pav-xthd

echo "Ensure the following line is the location of the device to back up."
echo "/run/user/1000/gvfs/$(ls /run/user/1000/gvfs/ | grep -i 'mtp')"

read -p "Transfering select files from ghost to pav-xthd/backups (any key to continue): " -n 1 -r
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	echo "Starting file transfer..."

  # create destination
  mkdir -p /media/cjpavlov/pav-xthd/backups/ghost/

  # recursive copy, no replace
  cp -rvn /run/user/1000/gvfs/$(ls /run/user/1000/gvfs/ | grep -i 'mtp')/* /media/cjpavlov/pav-xthd/backups/ghost/

	echo "Syncing data..."
	sync

	echo "Transfer complete!"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
