#!/bin/bash
# update script for Manjaro Linux

# prompt to update selected mirrors
read -p "Would you like to select a faster mirror before updating? [y/N]: " -r
if [[ "$REPLY" =~ ^[yY] ]]; then
    echo "Grabbing fastest mirrors..."
    sudo pacman-mirrors --fasttrack
fi

echo; echo "Updating..."; echo
yaourt -Syua

# prompt for clean up
read -p "Would you like to remove non-essential packages? [y/N]: " -r
if [[ "$REPLY" =~ ^[yY] ]]; then
    yaourt -Qdt
    yaourt -Rs $(pacman -Qtdq)
fi

echo; echo "Complete."; echo

# prompt for system restart
read -p "Reboot recommended, do this now? [y/N]: " -r
if [[ "$REPLY" =~ ^[yY] ]]; then
    sudo reboot
fi

exit 0 || return 0
