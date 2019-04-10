#!/bin/bash
# Synchronize all BackUp folders into master

# if not mounted...
if [[ -d /run/media/cjpavlov/pav-msd/storage ]]; then
	wrkPath="run/media/cjpavlov/pav-msd/storage"
elif [[ -d /mnt/drives/pav-msd/storage ]]; then
	wrkPath="/mnt/drives/pav-msd/storage"
else
	printf "error: pav-msd not mounted" >&2
	exit 1
fi

errorStat=0
curId="$(echo $UID)"

if [$curId -eq 0]; then
	printf "\nThis script should not be run as root.\nExiting.\n"
	printf "error: cannot run as root\n" >&2
	exit 1
fi

# prompt and go
read -p "Consolidate data from backups to master? [Y/n]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[nN] ]]; then
	if [[ -d "$wrkPath/master/" ]]; then
		if [[ -d "$wrkPath/backups" ]]; then
			# linux systems
			cp -rvn $wrkPath/backups/pav-[1345]/* $wrkPath/master/
			sync
		fi

		if [[ -d "$wrkPath/FileHistory/CJPavlovich/PAV3" ]]; then
			# pav-3
			cp -rvn $wrkPath/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/* $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/Documents $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/Desktop $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/CJPavlovich/PAV3/Data/C/Users/CJPavlovich/code $wrkPath/master/
			sync
		fi

		if [[ -d "$wrkPath/backups/pav-4" ]]; then
			# pav-4
			cp -rvu $wrkPath/backups/pav-4/Desktop $wrkPath/master/
			cp -rvu $wrkPath/backups/pav-4/Documents $wrkPath/master/
			cp -rvu $wrkPath/backups/pav-4/code $wrkPath/master/
			sync
		fi

		if [[ -d "$wrkPath/backups/royale-old-1" ]]; then
			# old backups
			cp -rvn $wrkPath/backups/royale-old-1/* $wrkPath/master/
			cp -rvn $wrkPath/backups/royale-old-1/* $wrkPath/master/
			cp -rvu $wrkPath/backups/royale-old-1/bin* $wrkPath/master/
			cp -rvu $wrkPath/backups/royale-old-1/Documents $wrkPath/master/
			cp -rvu $wrkPath/backups/royale-old-1/MyCode $wrkPath/master/
			rm -rvf $wrkPath/backups/royale-old-1
			sync
		fi

		if [[ -d "$wrkPath/FileHistory/cpav" ]]; then
			cp -rvn $wrkPath/FileHistory/cpav/PAV5/Data/C/Users/cpav/* $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/cpav/PAV5/Data/C/Users/cpav/Documents $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/cpav/PAV5/Data/C/Users/cpav/Desktop $wrkPath/master/
			cp -rvu $wrkPath/FileHistory/cpav/PAV5/Data/C/Users/cpav/code $wrkPath/master/
			sync
		fi

		if [[ -d "$wrkPath/FileHistory/cpav-old-1" ]]; then
			cp -rvn $wrkPath/FileHistory/cpav-old-1/PAV5/Data/C/Users/cpav/* $wrkPath/master/
			rm -rvf $wrkPath/FileHistory/cpav-old-1
		fi
	fi

	if [errorStat -ne 0]; then
		echo "errors found" >&2
		exit 1
	fi
fi

printf "\nComplete.\n"
printf "\nIf errors were seen and this is of concern to you, you might check file permissions.\n"

exit 0
