#!/bin/bash
# Synchronize all BackUp folders into master

read -p "Consolidate data from backups to master? (any key to continue) " -n 1 -r
echo
if [[ ! $REPLY =~ ^{Yy]$ ]]
then

	# Copies new data from external to storage... (no loss)
	echo "- Pass 1..."

	echo "-- Pav 3"
	# sudo cp -rn /mnt/drives/storage/backups/pav-3/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/* /mnt/drives/storage/master/

	echo "-- Pav 4"
	# sudo cp -rn /mnt/drives/storage/backups/pav-4/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/backups/royale-old-1/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/backups/royale-old-1/* /mnt/drives/storage/master/
	rm -rf /mnt/drives/storage/backups/royale-old-1

	echo "-- Pav 5"
	sudo cp -rn /mnt/drives/storage/FileHistory/cpav/PAV5/Data/C/Users/cpav/* /mnt/drives/storage/master/
	sudo cp -rn /mnt/drives/storage/FileHistory/cpav-old-1/PAV5/Data/C/Users/cpav/* /mnt/drives/storage/master/
	rm -rf /mnt/drives/storage/FileHistory/cpav-old-1

	echo "- Pass 1: Complete"


	# Copies updated data from external to storage... (updates old docs)
	echo "- Pass 2..."

	echo "-- Pav 3"
	sudo cp -ru /mnt/drives/storage/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/Documents /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/Desktop /mnt/drives/storage/master/

	echo "-- royale-old-1"
	sudo cp -ru /mnt/drives/storage/backups/royale-old-1/bin* /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/royale-old-1/Documents /mnt/drives/storage/master/
	sudo cp -ru /mnt/drives/storage/backups/royale-old-1/MyCode /mnt/drives/storage/master/

	echo "- Pass 2: Complete"

	echo "Finishing up..."
	sync

	echo
	echo "Complete."
	echo

	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
