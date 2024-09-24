#!/bin/bash
# Filename: format.sh
# Author: Chris Pavlovich
# Edited: Apr 15, 2019
# Description: general use bash script format

# variable declarations
___status___=0

# install docker
function install_docker() {
    # uninstall conflicting docker instances
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
 
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
}

# install software
function install_software() {
    sudo apt-get update
    sudo apt-get install ssh npm nodejs vim htop nginx

    sudo docker compose ls; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        install_docker
    fi

    return 0
}

# configure OS
function configure_os() {
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

    return $?
}

# check each software is installed
check_installs() {
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
    sudo docker compose ls;
    if [ $? -ne 0 ]; then
        ___status___=1
    fi

    return $___status___
}

# script driver
function main() {
    check_installs; ___status___=$?
    if [ $___status___ -ne 0 ]; then
        install_software
    fi

    configure_os
    
    return $___status___
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "WARN: exiting with non-zero status ($___status___)"
fi

exit $___status___ || return $___status___
