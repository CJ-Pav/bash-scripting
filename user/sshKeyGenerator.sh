#!/bin/bash
## Program: sshKeyGenerator.sh
## Author: Chris Pavlovich
## Edited: Mar 6, 2019

# windows git bash will respond to ~ by def w/ /c/users/username
# linux terminal will respond to ~ by def w/ /home/username

gen=0; userName="$(whoami)"; email=""; ___status___=0
rsaPath="$(echo ~)/.ssh"; startDir="$(pwd)"

if [[ -s "$rsaPath" ]] && [[ -r "$rsaPath" ]]; then
    echo "Key located."; gen=1
elif [[ -s "/home/$userName/.ssh/id_rsa" ]] && [[ -r "/home/$userName/.ssh/id_rsa" ]]; then
    echo "Key located."; gen=1
else
    echo "No ssh key detected."
    read -p "Generate new ssh key now? [Y/n]: " -r
    if [[ "$REPLY" =~ ^[nN] ]]; then
        echo "no ssh key, failed" >&2
        ___status___=1
    else # generate ssh key
        gen=0
    fi
fi

if [ $___status___ -eq 0 ]; then
    # grab email if not already done
    while [[ -z "$email" ]]; do
        read -p "Enter an email address: " email
    done

    # grab gitName if not already done
    while [[ -z "$gitName" ]]; do
        read -p "Enter a git username: " gitName
    done

    # if "gen key" flag is set, generate a key
    if [ $gen -eq 0 ]; then
        ssh-keygen -t rsa -b 4096 -C "$email"
    fi

    # add key combo to agent
    read -p "Would you like the key unlock at login? [Y/n]: " -r
    if [[ "$REPLY" =~ ^[nN] ]]; then
        eval $(ssh-agent -s)
        ssh-add "$rsaPath"
    fi
fi

exit $___status___ || return $___status___
