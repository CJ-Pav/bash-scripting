#!/bin/sh
# Filename: admin-utility.sh
# Author: Chris Pavlovich
# Edited: Sep 24, 2024
# Description: Web server configuration utility.

# 3 > ptech-errors.log

# variable declarations (0 = true)
___status___=0
__is_finished__=1
__command__=""
__username__=""
ssh_email=""
git_email=""
git_username=""

___input___=""

# ensure root login
function checkRoot() {
    if [ $UID -ne 0 ]; then
        echo; echo "Error: this script must be run as root."
        exit 1
    fi; echo
    return 0
}

# create admins, groups, and add to/fro
function createAdmins() {
    if [[ ! -d "/home/cjpavlovich" ]]; then
        useradd -m cjpavlovich; echo "N3Wh@v3n
        N3Wh@v3n" | passwd cjpavlovich
    fi
    return 0
}
function createGroups() {
    groupadd -v ptech
    return 0
}
function addAdminsToGroups() {
    useradd -aG cjpavlovich ptech
    return 0
}

function sshConfiguration() {
    # get user to config for
    while [[ -z "$__username__" ]]; do
        profiles="$(ls /home/)"
        echo "The following user profiles were found:"; echo "$profiles"; echo
        read -p "Which user profile is this key for? " __username__
        echo "Suggested location for key: /home/$__username__/.ssh/$__username__\_rsa"
    done
    while [[ -z "$ssh_email" ]]; do
        read -p "Enter an email address for key: " ssh_email
    done
    # gen key in profile for email address
    ssh-keygen -t rsa -b 4096 -C "$ssh_email"
    return 0
}

function config() {
    echo "Configuration options..."
    echo " user-config     -   create admin users"
    echo " group-config    -   create admin groups"
    echo " ssh-config      -   generate key pair and/or add to ssh-agent"
    echo " git-config      -   configure git global settings"
    echo " init-default    -   run all above commands"
}

# run command
function execute() {
    echo "Execute received: $1"
    # if [ $# -gt 0 ]; then
    #     if [[ "$1" == "exit" ]]; then
    #         __is_finished__=0; echo "Exiting script..."
    #     elif [[ "$1" == "config" ]]; then
    #         createAdmins
    #     elif [[ "$1" == "user-config" ]]; then
    #         createAdmins
    #     elif [[ "$1" == "group-config" ]]; then
    #         createGroups; addAdminsToGroups
    #     # elif [[ "$1" == "web-config" ]]; then
    #     #     createGroups; addAdminsToGroups
    #     elif [[ "$1" == "ssh-config" ]]; then
    #         sshConfiguration
    #     else
    #         echo "Command not found"
    #         return 1
    #     fi
    # fi
    return 0
}

# do nothing
function menu() {
    while [ $__is_finished__ -ne 0 ]; do
        echo " config    -   view configuration options"
        echo " web       -   (broken) web services"
        echo " vpn       -   (broken) start vpn connection"
        echo " exit      -   return to shell"
        # prompt user until valid input received
        while [[ -z "$__command__" ]]; do
            read -p "Enter a command: " $__command__
            execute "$__command__"; ___status___=$?
            # if returned non-zero, then bad input and make null
            if [ $___status___ -ne 0 ]; then
                __command__=""
            fi
        done
    done
    return 0
}

function ptech_AU_install() {
    mkdir -p /home/ptech/.data/
    touch /home/ptech/.data/install.ptech

    ### confirm username
    __username__=$USER
    escape=1
    while [[ $escape -ne 0 ]]; do
        read -p "Is $__username__ your username? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^{Yy]$ ]]
            read -p "Enter username: " $__username__
        else
            escape=0
        fi
    done;
    
    ### get user email
    if [[ -z "$ssh_email" ]]; do
        read -p "Enter your user email: " $ssh_email
    done

    ### confirm user email
    escape=1
    while [[ $escape -ne 0 ]]; do
        read -p "Is $ssh_email correct? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^{Yy]$ ]]
            read -p "Re-enter email: " $__username__
        else
            escape=0
        fi
    done;

    ### check ssh keys
    # see if key exists, if not then create one
    ls /home/$__username__/.ssh/ | grep -i "id"; ___status___=$?
    if [ ___status___ -ne 0 ]; then
        ssh-keygen -t ed25519 -C "$ssh_email"
    fi

    echo "Copy this pub key to your github account."
    cat /home/$__username__/.ssh/id*.pub

    read -p "Press any key when done..." -r -n 1

    # clone AU repo
    git clone git@github.com:CJ-Pav/bash-scripting.git

    echo "Exiting. Run admin-utility script in the new bash-scripting folder."

    # store installer data in group folder
    echo "username: $__username__" > /home/ptech/.data/install.ptech
    echo "email: $ssh_email" /home/ptech/.data/install.ptech

    return 0
}

# ptech_configuration
function ptech_configuration() {
    # check scripts
    ls /etc/ | grep -i "ptech"; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        # config missing, run install
        ptech_AU_install;
        exit 0
    else
        # self updater
        git pull; ___status___=$?
        if [ $___status___ -ne 0 ]; then
            echo "Failed to auto update. Exiting."
            return 1
        else
            echo "Self update complete."
        fi
    fi

    # check mandatory software
    ./ptech/check_software.sh; ___status___=$?

    return $___status___
}

# script driver
function main() {
    echo; echo "*** Pavlovich Technologies Beta ***"; checkRoot
    echo "Read the README.md file included before using this tool."

    # confirm with user
    read -p "Add ptech configuration to this system? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^{Yy]$ ]]
        ptech_configuration; ___status___=$?
    fi

    if [ $___status___ -ne 0 ]; then
        echo "Warning: ptech_configuration exited with error status."

    echo "Complete."
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "Warning: main exited w/ status $___status___"
fi

exit $___status___ || return $___status___
