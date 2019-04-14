#!/bin/bash
# fedora update script

echo "Checking for and applying all updates and upgrades."

sudo dnf -y update
echo
sudo dnf -y upgrade
echo

echo "Complete"

