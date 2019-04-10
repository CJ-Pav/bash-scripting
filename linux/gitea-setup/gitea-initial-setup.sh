#!/bin/sh
## Program: gitea-initial-setup.sh
## Author: Chris Pavlovich
## Date: Nov 19, 2018

# variables declared/initialized
_status_=0

# ensure user is not root
if [ $UID -eq 0 ]; then
	# download gitea binary
	wget -O gitea https://dl.gitea.io/gitea/1.5.0/gitea-1.5.0-linux-amd64
	chmod +x gitea

	# verify download
	gpg --keyserver pgp.mit.edu --recv 7C9E68152594688862D62AF62D9AE806EC1592E2
	gpg --verify gitea-1.5.0-linux-amd64.asc gitea-1.5.0-linux-amd64
	
	# test
	# ./gitea web

	echo "setup incomplete, visit <https://docs.gitea.io/en-us/install-from-binary/> to complete."
	_status_=1
fi

exit $_status_ || return $_status_

