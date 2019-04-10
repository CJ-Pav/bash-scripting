#!/bin/sh
# MX post install script: basic software packages

echo
echo " - Updates..."
pkg_add -u

echo
echo " - Installs..."
pkg_add -v rsync
pkg_add -v gcc
pkg_add -v g++
pkg_add -v node
pkg_add -v git
pkg_add -v python-3.6.4p0
pkg_add -v zsh
pkg_add -v bash
pkg_add -v vim
pkg_add -v htop

# pkg_add -v atom
# pkg_add -v clang

echo
read -p "Complete. Would you like to reboot? [Y/n]" -n 1 -r

echo

exit 0
