#!/bin/sh
# Filename: post-build_fedora-29-server-0.1
# Author: Chris Pavlovich
# Edited: Feb 27, 2019
# Description: setup/config after base install of Fedora 29

# variable declarations
___status___=0

function updates() {
    sudo dnf -y update
    sudo dnf -y upgrade
    
    cleanUp

    return 0
}

function softwareInstalls() {
    sudo dnf -y install vim
    sudo dnf -y install htop
    sudo dnf -y install git
    sudo dnf -y install gcc
    sudo dnf -y install clang
    sudo dnf -y install firewalld
    sudo dnf -y install tlp
    sudo dnf -y install openssh
    sudo dnf -y install gdb
    sudo dnf -y install nodejs
    sudo dnf -y install npm

    cleanUp

    return 0
}

function softwareEnabling() {
    sudo systemctl enable sshd
    sudo systemctl enable tlp
    sudo systemctl enable firewalld
    
    cleanUp
    
    return 0
}

function cleanUp() {
    # apply common fixes if error detected
    if [ $___status___ -ne 0 ]; then
        sudo dnf -y autoremove

        ___status___=0
    fi

    return 0
}

# script driver
function main() {
    hostname; ___status___=$?
    updates; ___status___=$?
    softwareInstalls; ___status___=$?
    softwareEnabling; ___status___=$?
    
    return $___status___
}

# driver call; store status
main; ___status___=$?

# error message if non zero return
if [ $___status___ -ne 0 ]; then
    echo "Warning: exiting w/ status $___status___"
fi

exit $___status___ || return $___status___
