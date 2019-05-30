#!/bin/bash
# Filename: update-centos-server.sh
# Author: Chris Pavlovich
# Edited: May 28, 2019
# Description: CentOS update script

echo "Checking for and applying all updates and upgrades."

sudo yum -y update
echo
sudo yum -y upgrade
echo

echo "Checking for and removing any unnecessary dependencies."

sudo yum -y autoremove
echo

echo "done"
echo

