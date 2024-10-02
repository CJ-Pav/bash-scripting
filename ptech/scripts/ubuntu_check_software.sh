#!/bin/bash
# Filename: format.sh
# Author: Chris Pavlovich
# Edited: Apr 15, 2019
# Description: general use bash script format

# install software
function install_software() {
    # updates
    sudo apt-get -y update; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        install_docker
    fi

    # installs
    sudo apt-get -y install curl
    sudo apt-get -y install ssh
    sudo apt-get -y install npm
    sudo apt-get -y install nodejs
    sudo apt-get -y install vim
    sudo apt-get -y install htop
    sudo apt-get -y install nginx
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot
    sudo snap install docker

    return $___status___
}

# configure OS
function configure_os() {
    ___status___=0

    # enable services
    sudo systemctl enable ssh
    sudo systemctl enable nginx
    sudo ufw enable

    # configure firewall
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw allow ssh
    sudo ufw allow 3000
    sudo ufw allow 3001
    sudo ufw allow 3002

    return $___status___
}

# check each software is installed
check_installs() {
    ___status___=0
    
    dpkg -s curl
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s ssh
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s npm;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s nodejs;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s vim;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s htop;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s nginx;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s certbot
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    dpkg -s python-certbot-nginx
    if [ $? -ne 0 ]; then
        ___status___=1
    fi
    sudo docker compose ls;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi

    return $___status___
}

# script driver
function ubuntu_check_software() {
    check_installs; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        install_software
    fi

    configure_os; ___status___=$?
    
    return $___status___
}
