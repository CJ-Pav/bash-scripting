#!/bin/bash
## Program: gitConfig.sh
## Author: Chris Pavlovich
## Edited: Feb 9, 2019

# windows git bash will respond to ~ by def w/ /c/users/username
# linux terminal will respond to ~ by def w/ /home/username

gen=0; userName="$(whoami)"; gitName=""; email=""; _status_=0
rsaPath="~/.ssh"; startDir="$(pwd)"; preKey=1

if [[ -s "$rsaPath/id_rsa" ]] && [[ -s "$rsaPath/id_rsa.pub" ]]; then
    echo "Key pair located."; preKey=0
elif [[ -s "/home/$userName/.ssh/id_rsa" ]] && [[ -s "/home/$userName/.ssh/id_rsa.pub" ]]; then
    echo "Key pair located."; preKey=0
fi

echo "No ssh key detected."
read -p "Generate new ssh key now? [Y/n]: " -r
if [[ "$REPLY" =~ ^[nN] ]]; then
    gen=1
    echo "ERROR: no key pair and user denied generation." >&2
    _status_=1
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

