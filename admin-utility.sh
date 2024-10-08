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
source /home/ptech/bash-scripting/ptech/scripts/ubuntu_check_software.sh
source /home/ptech/bash-scripting/ptech/scripts/web_server_manager.sh

#####################
### CONFIGURATION ###
#####################
# variable declarations (0 = true)
___status___=0
__username__=""
ssh_email=""
__work_dir___=$pwd

# check ssh keys are installed, install, clone repo
function check_ssh_keys() {
    # see if key exists, if not then create one
    ls /home/$__username__/.ssh/ | grep -i "id"; ___status___=$?
    if [ $___status___ -ne 0 ]; then
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
    
        ### generate key
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
function clone_repo() {
    # make sure git installed
    dpkg -s git; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        sudo apt-get -y update
        sudo apt-get -y install git
    fi

    # clone AU repo
    ls /home/ptech/bash-scripting/ptech/ | grep -i "scripts"; ___status___=$?
    if [ $___status___ -eq 0 ]; then
        rm -rvf /home/ptech/bash-scripting/
    fi
    git clone git@github.com:CJ-Pav/bash-scripting.git /home/ptech/bash-scripting
}

# admin utility installer, sets up ssh key if dne and grabs scripts from Github
function ptech_AU_install() {
    sudo mkdir -p /home/ptech/.data/
    sudo touch /home/ptech/.data/install.ptech
    sudo chown cjpavlovich /home/ptech

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

    ### check ssh keys
    check_ssh_keys

    clone_repo

    ls /usr/bin | grep -i "ptech-au"; ___status___=$?
    if [ $___status___ -eq 0 ]; then
        sudo rm /usr/bin/ptech-au
    fi
    sudo ln -s /home/ptech/bash-scripting/admin-utility.sh /usr/bin/ptech-au

    echo "Exiting. Run admin-utility script non locally ($ ptech-au)."

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
        ls /home/ptech/bash-scripting/ptech/ | grep -i "scripts"; ___status___=$?
        if [ $___status___ -ne 0 ]; then
            echo "Unable to locate install files."
            echo "Make sure to run this non locally ($ ptech-au)"
            read -p "Re run installer? [y/N]: " -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Running install."
                ptech_AU_install
            fi
            exit 1
        fi
    fi

    version=0

    # grab current version
    version=$(cat /home/ptech/bash-scripting/ptech/.data | grep -i "version")

    # self updater
    sudo rm -r /home/ptech/bash-scripting

    git clone git@github.com:CJ-Pav/bash-scripting.git /home/ptech/bash-scripting; ___status___=$?

    if [ $___status___ -ne 0 ]; then
        echo "Failed to auto update. Exiting."
        return 1
    fi

    # make scripts executable
    chmod +x /home/ptech/bash-scripting/admin-utility.sh
    chmod +x /home/ptech/bash-scripting/ptech/scripts/ubuntu_check_software.sh
    chmod +x /home/ptech/bash-scripting/ptech/scripts/web_server_manager.sh

    echo "Self update complete.";

    # restart application if update took place
    new_version=$(cat /home/ptech/bash-scripting/ptech/.data | grep -i "version")
    if [[ ! $version == $new_version ]]; then
        echo "An update to source files has taken place. Please re-run this application. Exiting."
	exit 0
    fi

    # check mandatory software
    ubuntu_check_software; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        echo "Warning: software check returned error status"
    fi

    return 0
}


####################
### PROGRAM MAIN ###
####################
__selection__=""

# admin untilities menu
function admin_utilities_menu() {
    escape=1
    while [ $escape -ne 0 ]; do
        echo; cat /home/ptech/bash-scripting/ptech/menu/main_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq -1 ]; then
        
            # error
            echo "Warning: admin utility exited with error status."
        elif [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            # webserver management
            web_server_management
        elif [ $__selection__ -eq 8 ]; then
            # uninstall
            read -p "Warning: this will remove admin utilities and all related configurations. Continue? [y/N]: " -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo rm -rvf /home/ptech
            fi
            echo "Uninstall complete."
            exit 0
        elif [ $__selection__ -eq 9 ]; then
            # reinstall
            sudo rm -rvf /home/ptech
            sudo ufw --force disable
            sudo ufw --force reset
            ptech_configuration
        fi
    done
    return $___status___
}

# script driver
function main() {
    echo; echo "*** Pavlovich Technologies Beta ***"
    echo "Read the README.md file included before using this tool."; echo

    read -p "Welcome to the admin utilities tool set. Press any key to continue." -n 1 -r
    
    # cannot be run from within /home/ptech/
    if [[ $__work_dir___ =~ "/home/ptech" ]]; then
        echo "Error: script will crash if you run it from within /home/ptech"
        exit 1
    fi

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
