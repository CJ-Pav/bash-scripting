#!/bin/bash
# update script for mint

echo; echo "Updating system..."

sudo apt update -y
sudo apt upgrade -y

echo; echo "Cleaning up..."

sudo apt autoremove -y
sudo apt clean metadata

echo; echo "Complete."
