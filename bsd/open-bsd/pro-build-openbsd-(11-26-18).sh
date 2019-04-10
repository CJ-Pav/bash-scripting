#!/bin/sh
# Program Filename: pro-build-openbsd
# Author: Chris Pavlovich
# Date: Nov 26, 2018
# Description: OpenBSD Setup Script

# variable declarations
___status___=0

# do nothing

# update packages
# function updates() {
    echo; echo " - Updating - "; echo
    pkg_add -u

    # return 0
# }

# install packages
# function installs() {
    echo; echo " - Installs - "; echo
    pkg_add -v rsync
    pkg_add -v gcc
    pkg_add -v g++
    pkg_add -v gdb
    pkg_add -v node
    pkg_add -v git
    pkg_add -v python-3.6.4p0
    pkg_add -v zsh
    pkg_add -v bash
    pkg_add -v vim
    pkg_add -v htop
    # return 0
# }

# remove packages
# function removals() {
#     holdYourHorses # replace with removal lines
#     return 0
# }

# script driver
# function main() {
    # echo
    # read -p "Complete. Would you like to reboot? [Y/n]: " -r
    # if [[ "$REPLY" =~ ^[nN] ]]; then
    #     echo "Error: reboot suggested." >&2
    #     ___status___=1
    # else
        reboot
    #     ___status___=0
    # fi
    # return $___status___
# }

# call driver
# main; ___status___=$?

exit $___status___ || return $___status___
