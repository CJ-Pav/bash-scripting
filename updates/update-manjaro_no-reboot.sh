#!/bin/bash
# update script for Manjaro Linux

# echo "Grabbing fastest mirrors..."
# sudo pacman-mirrors --fasttrack

echo "Checking for & running updates..."
yaourt -Syua

echo "Complete"
