#!/bin/bash
# Synchronize master directories

read -p "Consolidating data from backups to master (any key to continue): " -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then # Migrate master from pav-x to storage

	cp -rvu /mnt/drives/pav-x/master/* /mnt/drives/storage/master
	echo

	sync
	echo
	echo "done"

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
