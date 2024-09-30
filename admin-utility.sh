#!/bin/bash
# Filename: admin-utility.sh
# Author: Chris Pavlovich
# Edited: Sep 24, 2024
# Description: Web server configuration utility.
#               - Opens ports 22, 80, 443, 3000-3002
#               - Installs htop, docker, npm, git, and anything else needed for
#                 minimum functionality.
#               - Will generate SSH key if none found

# 3 > ptech-errors.log

# imports
source ptech/scripts/ubuntu_check_software.sh
source ptech/scripts/web_server_manager.sh

# variable declarations (0 = true)
___status___=0


#####################
### CONFIGURATION ###
#####################
__username__=""
ssh_email=""

# check ssh keys are installed, install, clone repo
check_ssh_keys() {
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
}

# clone repo
clone_repo() {
    # make sure git installed
    dpkg -s git; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        sudo apt-get -y update
        sudo apt-get -y install git
    fi

    # clone AU repo
    git clone git@github.com:CJ-Pav/bash-scripting.git /home/ptech/bash-scripting
}

# admin utility installer, sets up ssh key if dne and grabs scripts from Github
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
    check_ssh_keys

    clone_repo

    echo "Exiting. Run admin-utility script in the new bash-scripting folder."

    exit 0
}

# ptech_configuration
function ptech_configuration() {
    # check scripts
    cat /home/ptech/.data/install.ptech | grep -i "username"; ___status___=$?
    # if username field is populated in the install.ptech file, then status = 0
    if [ $___status___ -ne 0 ]; then
        echo "Configuration files missing, running first time install."
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
            fi
            exit 1
        fi
    fi

    # self updater
    git pull; ___status___=$?

    # make scripts executable
    chmod +x ptech/scripts/ubuntu_check_software.sh
    chmod +x ptech/scripts/web_server_manager.sh

    if [ $___status___ -ne 0 ]; then
        echo "Failed to auto update. Exiting."
        return 1
    else
        echo "Self update complete."
    fi

    # check mandatory software
    ptech/scripts/ubuntu_check_software.sh; ___status___=$?

    return $___status___
}


####################
### PROGRAM MAIN ###
####################
__selection__=""

# admin untilities menu
function admin_utilities_menu() {
    escape=1
    while [ escape -ne 0 ]; do
        cat ./ptech/menu/main_menu

        read -p "Selection (#): " -r
        if [ $___status___ -eq -1 ]; then
            # error
            echo "Warning: admin utility exited with error status."
        elif [ $___status___ -eq 0 ]; then
            # exit
            escape=0
        elif [ $___status___ -eq 1 ]; then
            # webserver management
            web_server_management
        elif [ $___status___ -eq 8 ]; then
            # uninstall
            read -p "Warning: this will remove admin utilities and all related configurations. Continue? [y/N]: " -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo rm -rvf /home/ptech
            else
                ___status___=0
            fi
        fi
    done
    return $___status___
}

# script driver
function main() {
    echo; echo "*** Pavlovich Technologies Beta ***"
    echo "Read the README.md file included before using this tool."

    read -p "Welcome to the admin utilities tool set. Press any key to continue." -n 1 -r
    
    # installer
    ptech_configuration; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        echo "Warning: ptech_configuration exited with error status."
    fi

    # admin utilities menu
    admin_utilities_menu

    return $___status___
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "Warning: main exited w/ status $___status___"
fi

exit $___status___ || return $___status___
