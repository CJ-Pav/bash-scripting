#!/bin/sh
# Filename: ssh-ip-ban.sh
# Author: Chris Pavlovich
# Edited: Feb 18, 2019
# Description: ban specified IP from firewalld

___ipv4ToBan___="0.0.0.0"

# do nothing
function hammerTime() {
    read -p "Enter the IP Address to ban: " ___ipv4ToBan___ 
    read -p "$___ipv4ToBan___ is about to receive the ban hammer. Continue? [Y/n]: " -r

    if [[ "$REPLY" =~ ^[nN] ]]; then
        return 1
    else
        # block ipv4 address
        echo "Banning IPV4 address $___ipv4ToBan___"
        sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$___ipv4ToBan___' reject"
        
        # block on known ssh ports
        echo "Banning IP on port 22"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 22 -j REJECT
        echo "Banning IP range on port 22"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 22 -j REJECT
        echo "Banning IP on port 50535"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 50535 -j REJECT
        echo "Banning IP range on port 50535"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 50535 -j REJECT
        echo "Banning IP on port 49950"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 49950 -j REJECT
        echo "Banning IP range on port 49950"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 49950 -j REJECT
        echo "Banning IP on port 53162"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 53162 -j REJECT
        echo "Banning IP range on port 53162"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 53162 -j REJECT
        echo "Banning IP on port 46956"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 46956 -j REJECT
        echo "Banning IP range on port 46956"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 46956 -j REJECT
        echo "Banning IP on port 63517"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___ -p tcp --dport 63517 -j REJECT
        echo "Banning IP range on port 63517"
        sudo firewall-cmd --direct --add-rule ipv4 filter INPUT 1 -m tcp --source $___ipv4ToBan___/24 -p tcp --dport 63517 -j REJECT

        # reload firewall
        echo "Reloading FirewallD"
        sudo firewall-cmd --reload
    fi

    return 0
}

# script driver
function main() {
    hammerTime

    if [ $? -ne 0 ]; then
        return 1
    fi
    
    return 0
}

main

if [ $? -ne 0 ]; then
    echo "Warning: exiting w/ non-zero status."
    exit 1
fi

exit 0
