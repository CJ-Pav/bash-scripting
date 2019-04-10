#!/bin/bash
# fedora update script

echo "Checking for and applying all updates and upgrades."

sudo dnf -y update
echo
sudo dnf -y upgrade
echo

echo "Checking for and removing any unnecessary dependencies."

sudo dnf -y autoremove
echo

echo "Clearing cache"

sudo dnf clean metadata

echo "done"
echo

