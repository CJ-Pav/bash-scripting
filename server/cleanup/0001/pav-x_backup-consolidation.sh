#!/bin/bash
# Synchronize all BackUp folders into master

read -p "Consolidate data from backups to master? (any key to continue) " -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then
	# Copies new data from external to storage... (no loss)
	# Only royale files will update if newer
	echo "- Pass 1..."
	echo "-- Pav 3"
	sudo cp -rn /mnt/drives/pav-x/backups/pav-3/* 			/mnt/drives/pav-x/master/ && sync
	echo "-- Pav 4"
	sudo cp -ru /mnt/drives/pav-x/backups/pav-4/* 			/mnt/drives/pav-x/master/ && sync
	echo "-- Pav 5"
	sudo cp -rn /mnt/drives/pav-x/backups/pav-5/* 			/mnt/drives/pav-x/master/ && sync
	sudo cp -rn /mnt/drives/pav-x/FileHistory/cpav/PAV5/Data/C/Users/cpav/* 			/mnt/drives/pav-x/master/ && sync

	echo "-- Royale"
	sudo cp -rn /mnt/drives/pav-x/backups/royale/* 		/mnt/drives/pav-x/master/ && sync
	echo "- Pass 1: Complete."

	# Copies updated data from external to storage... (updates old docs)
	echo "- Pass 2..."
	echo "-- Pav 3"
	sudo cp -ru /mnt/drives/pav-x/backups/pav-3/Documents 		/mnt/drives/pav-x/master/ && sync
	# echo "-- Pav 4"
	# sudo cp -ru /mnt/drives/pav-x/backups/pav-4/Documents 		/mnt/drives/pav-x/master/ && sync
	echo "-- Pav 5"
	sudo cp -ru /mnt/drives/pav-x/backups/pav-3/bin-royale 	/mnt/drives/pav-x/master/ && sync
	sudo cp -ru /mnt/drives/pav-x/backups/pav-5/Documents 		/mnt/drives/pav-x/master/ && sync
	sudo cp -ru /mnt/drives/pav-x/backups/pav-5/MyCode 			/mnt/drives/pav-x/master/ && sync
	echo "-- Royale"
	sudo cp -ru /mnt/drives/pav-x/backups/royale/bin-royale 	/mnt/drives/pav-x/master/ && sync
	sudo cp -ru /mnt/drives/pav-x/backups/royale/Documents 	/mnt/drives/pav-x/master/ && sync
	sudo cp -ru /mnt/drives/pav-x/backups/royale/MyCode 			/mnt/drives/pav-x/master/ && sync
	sudo cp -ru /mnt/drives/pav-x/backups/royale/Support 		/mnt/drives/pav-x/master/ && sync
	echo "- Pass 2: Complete."

	echo "File sync..."
	sync

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
