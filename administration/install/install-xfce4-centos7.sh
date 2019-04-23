#!/bin/bash

_status_=0
if [ $UID -ne 0 ]; then
	echo "Error: must be root" >&2
	_status_=1
else
	# user has root permissions
	_status_=0
	yum install epel-release
	yum groupinstall "X Window system"
	yum groupinstall xfce
	systemctl isolate graphical.target
	systemctl set-default graphical.target
	reboot
fi
exit $_status_ || return $_status_
