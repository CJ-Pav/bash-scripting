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
    sudo ufw allow 3003
    sudo ufw allow 43210
    # sudo ufw allow 43211
    # sudo ufw allow 43212

    sudo su -c 'echo "configured_os=0" >> /home/ptech/.data/install.ptech'

    return $___status___
}

# check each software is installed
check_installs() {
    ___status___=0
    
    dpkg -s curl
    if [ $? -ne 0 ]; then
        echo "curl missing"
        ___status___=1
    fi
    dpkg -s ssh
    if [ $? -ne 0 ]; then
        echo "ssh missing"
        ___status___=1
    fi
    dpkg -s npm
    if [ $? -ne 0 ]; then
        echo "npm missing"
        ___status___=1
    fi
    dpkg -s nodejs
    if [ $? -ne 0 ]; then
        echo "nodejs missing"
        ___status___=1
    fi
    dpkg -s vim
    if [ $? -ne 0 ]; then
        echo "vim missing"
        ___status___=1
    fi
    dpkg -s htop
    if [ $? -ne 0 ]; then
        echo "htop missing"
        ___status___=1
    fi
    dpkg -s nginx
    if [ $? -ne 0 ]; then
        echo "nginx missing"
        ___status___=1
    fi
    sudo docker compose ls
    if [ $? -ne 0 ]; then
        echo "docker compose missing"
        ___status___=1
    fi

    if [ $___status___ -eq 0 ]; then
        sudo su -c 'echo "install_check=0" >> /home/ptech/.data/install.ptech'
    fi

    echo "Check installs finished. Status $___status___."

    return $___status___
}

# script driver
function ubuntu_check_software() {
    cat /home/ptech/.data/install.ptech | grep -i "install_check=0"; ___status___=$?

    if [ $___status___ -eq 0 ]; then
        echo "Software already installed. Run repair to force reinstall."
    else
        check_installs; ___status___=$?
        if [ $___status___ -ne 0 ]; then
            install_software
        fi
    fi

    cat /home/ptech/.data/install.ptech | grep -i "configured_os=0"; ___status___=$?

    if [ $___status___ -eq 0 ]; then
        echo "Config already installed. Run repair to force reinstall."
    else
        configure_os; ___status___=$?
    fi
    
    return $___status___
}
