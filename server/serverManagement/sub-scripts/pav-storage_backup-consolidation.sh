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
	sudo cp -ru /mnt/drives/storage/backups/pav-3/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/* /mnt/drives/storage/master/

	echo "-- Pav 4"
	sudo cp -ru /mnt/drives/storage/backups/pav-4/* /mnt/drives/storage/master/

	echo "-- Pav 5"
	sudo cp -rn /mnt/drives/storage/FileHistory/cpav/PAV5/Data/C/Users/cpav/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/FileHistory/cpav/PAV5/Data/C/Users/cpav/* /mnt/drives/storage/master/

	echo "-- Royale"
	sudo cp -rn /mnt/drives/storage/backups/royale/* /mnt/drives/storage/master/
	echo
	echo "sync"
	echo "- Pass 1: Complete"

	echo "Finishing up"
	echo
	sync

	echo "done"
	echo

	# Copies updated data from external to storage... (updates old docs)

	echo "- Pass 2..."

	echo "-- Pav 3"
	sudo cp -ru /mnt/drives/storage/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/Documents /mnt/drives/storage/master/

	# echo "-- Pav 4"
	# sudo cp -ru /mnt/drives/storage/backups/pav-4/Documents /mnt/drives/storage/master/

	echo "-- Pav 5"
	sudo cp -ru /mnt/drives/storage/backups/pav-3/bin-royale /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/pav-5/Documents /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/pav-5/MyCode /mnt/drives/storage/master/

	echo "-- Royale"
	sudo cp -ru /mnt/drives/storage/backups/royale/bin-royale /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/royale/Documents /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/royale/MyCode /mnt/drives/storage/master/
	echo "- Pass 2: Complete"

	echo "Finishing up"
	echo
	sync

	echo "done"
	echo

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
