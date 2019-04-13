#!/bin/bash
# Program Filename: install-virtualbox.sh
# Author: Chris Pavlovich
# Date: Nov 23, 2018
# Description: read the Filename

dnf -y update
dnf -y upgrade
dnf autoremove

dnf install gcc-c++ libcap-devel libcurl-devel libIDL-devel libstdc++-static \
  libxslt-devel libXmu-devel openssl-devel pam-devel pulseaudio-libs-devel \
  python-devel qt-devel SDL_ttf-devel SDL-static texlive-latex wine-core \
  device-mapper-devel wget subversion subversion-gnome kernel-devel \
  glibc-static zlib-static glibc-devel.i686 libstdc++.i686 libpng-devel

curl https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Linux_amd64.run > ./VirtualBox-5.2.22-126460-Linux_amd64.run
./VirtualBox-5.2.22-126460-Linux_amd64.run
