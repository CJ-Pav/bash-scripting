#!/bin/bash
# Program Filename: git-sync.sh
# Author: Christopher Pavlovich
# Date: July 23, 2018
# Description: Commit edits, pull remote changes, merge if possible,
#		commit merged files, push updates.

# run in any unix shell with git installed to sync with git (assuming repo is already cloned)
# run from base directory of any cloned repo

# set working directory & username
wrkPath=$(pwd)

# exit if root
if [[ "$(echo $UID)" == "0" ]] || [[ "$(whoami)" == "root" ]]; then
    echo "Warning: this does not need elevated permissions."
    read -p "Continue? [Y/n]: " -n 1 -r
    if [[ $REPLY =~ ^[Nn] ]]; then
        echo "Exiting script"
        exit 1
    fi
fi

# add & commit current changes
git add $wrkPath -A
git commit -m "Commit recent changes - CJ-Pav"

# pull external edits changes
git pull
git add $wrkPath -A
git commit -m "Merge - CJ-Pav"
git push
git status

return 0 || exit 0
