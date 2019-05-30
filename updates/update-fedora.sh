#!/bin/bash
# fedora update script

echo "Checking for and applying all updates and upgrades."; echo

sudo dnf -y update; echo
sudo dnf -y upgrade; echo

echo "Complete."

# prompt for restart
exho "System updated, reboot recommended."
read -p "Reboot now? [y/N]: " -r
if [[ "$REPLY" =~ ^[yY] ]]; then
    sudo reboot
fi

exit 0 || return 0