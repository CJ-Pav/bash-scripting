#!/bin/bash
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
    sudo mkdir -p /home/ptech/.data/
    sudo touch /home/ptech/.data/install.ptech

    ### confirm username
    __username__=$USER
    escape=1
    while [[ $escape -ne 0 ]]; do
        read -p "Is $__username__ your username? [y/N]: " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            read -p "Enter username: " __username__
        else
            escape=0
        fi
    done;
    
    ### get user email
    if [[ -z "$ssh_email" ]]; then
        read -p "Enter your user email: " ssh_email
    fi

    ### confirm user email
    escape=1
    while [[ $escape -ne 0 ]]; do
        read -p "Is $ssh_email correct? [y/N]: " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            read -p "Re-enter email: " __username__
        else
            escape=0
        fi
    done;

    ### check ssh keys
    # see if key exists, if not then create one
    ls /home/$__username__/.ssh/ | grep -i "id"; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        ssh-keygen -t ed25519 -C "$ssh_email"
    fi

    echo "Copy this pub key to your github account."
    cat /home/$__username__/.ssh/id*.pub

    # store installer data in group folder
    echo "username: $__username__" >> .tmp_dat.ptech
    echo "email: $ssh_email" >> .tmp_dat.ptech
    sudo su -c 'cat .tmp_dat.ptech > /home/ptech/.data/install.ptech'
    rm .tmp_dat.ptech
    # echo "username: $__username__" > /home/ptech/.data/install.ptech
    # echo "email: $ssh_email" > /home/ptech/.data/install.ptech

    read -p "Press enter/return when done..." -r

    # clone AU repo
    git clone git@github.com:CJ-Pav/bash-scripting.git

    echo "Exiting. Run admin-utility script in the new bash-scripting folder."

    return 0
}

# ptech_configuration
function ptech_configuration() {
    # check scripts
    cat /home/ptech/.data/install.ptech | grep -i "username"; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        echo "Config missing, running install."
        ptech_AU_install
        exit 0
    else
        echo "Configuration file found."

        # check for actual script files
        ls ptech/ | grep -i "scripts"; ___status___=$?
        if [ $___status___ -ne 0 ]; then
            echo "Unable to locate install files."
            echo "Make sure to run this from the bash-scripting repository."
            read -p "Re run installer? [y/N]: " -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Running install."
                ptech_AU_install
                exit 0
            fi
            exit 1
        fi
    fi

    # self updater
    git pull; ___status___=$?

    # make scripts executable
    chmod +x ptech/scripts/check_software.sh

    if [ $___status___ -ne 0 ]; then
        echo "Failed to auto update. Exiting."
        return 1
    else
        echo "Self update complete."
    fi

    # check mandatory software
    ptech/scripts/check_software.sh; ___status___=$?

    return $___status___
}

# script driver
function main() {
    echo; echo "*** Pavlovich Technologies Beta ***"
    echo "Read the README.md file included before using this tool."

    # confirm with user
    read -p "Add ptech configuration to this system? [y/N]: " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ptech_configuration; ___status___=$?
    else
        ___status___=0
    fi

    if [ $___status___ -ne 0 ]; then
        echo "Warning: ptech_configuration exited with error status."
    fi

    return $___status___
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "Warning: main exited w/ status $___status___"
fi

exit $___status___ || return $___status___
