#!/bin/bash
# Synchronize master directories

read -p "Consolidating data from backups to master (any key to continue): " -n 1 -r
echo
if [[ ! "$REPLY" =~ ^[Yy] ]]
then # Migrate master from pav-x to storage
	# attempt rsync, manual copy if fails
	rsync -avh /mnt/drives/pav-x/
	[ $? -ne 0 ] && cp -rvu /mnt/drives/pav-x/master/* /mnt/drives/storage/master

	echo

	sync
	echo
	echo "done"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
