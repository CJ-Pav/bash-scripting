#!/bin/bash
# Post install script for personal common packages.

echo

sudo dnf -y update
sudo dnf -y upgrade

sudo dnf -y autoremove
sudo dnf clean metadata

sudo reboot

echo "Complete, reboot recommended."
echo
