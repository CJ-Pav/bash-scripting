#!/bin/bash
# Program Filename: format.sh
# Author: Chris Pavlovich
# Date: Nov 22, 2018
# Description:

# backup home directory to server drive "pav-msd"
rsync -avh "~" "$USER@prolixitysolutions.com:/drives/pav-msd/backups/users/"

exit 0
