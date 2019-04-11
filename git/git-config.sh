#!/bin/bash
## Program: git-config.sh
## Author: Chris Pavlovich
## Edited: Feb 9, 2019

# tested in linux and windows (git bash)

# variable declarations
gen=0; gitName=""; email=""; _status_=0
rsaPath="~/.ssh"; startDir="$(pwd)"; preKey=1

function main() {
    read -p "Would you like to use an RSA key pair for authentication? [y/N]: " -r
    if [[ "$REPLY" =~ ^[nN] ]]; then
        
}

function checkForKey() {
    if [[ -s "$rsaPath/id_rsa" ]] && [[ -s "$rsaPath/id_rsa.pub" ]]; then
        echo "Key pair located."; preKey=0
    elif [[ -s "/home/$USER/.ssh/id_rsa" ]] && [[ -s "/home/$USER/.ssh/id_rsa.pub" ]]; then
        echo "Key pair located."; preKey=0
    fi

echo "No ssh key detected."
read -p "Generate new ssh key now? [Y/n]: " -r
if [[ "$REPLY" =~ ^[nN] ]]; then
    gen=1
    echo "WARN: no key pair in default location and user denied generation." >&2
else # generate ssh key
    gen=0
fi

if [ $_status_ -eq 0 ]; then
    # grab email if not already done
    while [[ -z "$email" ]]; do
        read -p "Enter an email address: " email
    done

    read -p "Set git global defaults? (recommended) [Y/n]: " -r
    if [[ ! "$REPLY" =~ [nN] ]]; then
        # grab gitName if not already done
        while [[ -z "$gitName" ]]; do
            read -p "Enter a git username: " gitName

            # must not be empty
            if [[ -z "$gitName" ]]; then
                echo "This field is required."
            fi
        done

        # configure git interface
        git config --global user.email "$email"
        git config --global user.name "$gitName"
    fi

    # if "gen key" flag is set, generate a key
    if [ $gen -eq 0 ]; then
        ssh-keygen -t rsa -b 4096 -C "$email"
    fi

    # add key combo to agent
    eval $(ssh-agent -s)
    ssh-add "$rsaPath"
fi


exit $_status_ || return $_status_

