#!/bin/bash -e
# Post install script for personal common packages.

echo
echo "Elevated permissions will be required for this script."
echo "If an error is reported, please inform an admin."
echo

function hostname() {
	read -p "Update hostname? [Y/n]: " -r
	if [[ ! "$REPLY" =~ ^[nN] ]]; then
		read -p "Enter a new hostname for "
	fi
}


function softwareInstalls() {
	# enable non-default repo(s)
	sudo dnf install fedora-workstation-repositories

	# install extra(s)
	sudo dnf -y install vim htop git gcc clang firewalld
	sudo dnf -y install tlp openssh gdb nodejs npm nginx
	sudo dnf -y install ImageMagick chromium gedit filezilla
	sudo dnf -y install terminator transmission

	# prompt for proprietary installs
	echo "The following proprietary (not open source) software is available..."
	echo " - Google Chrome"
	echo " - Visual Studio Code"
	read -p "Install Google Chrome? [Y/n]: " __chrome__
	if [[ ! "$__chrome__" =~ ^[nN] ]]; then
		sudo dnf config-manager --set-enabled google-chrome
		sudo dnf install google-chrome-stable
	fi
	read -p "Install Visual Studio Code? [Y/n]: " __vscode__
	if [[ ! "$__vscode__" =~ ^[nN] ]]; then
		sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
		sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
		dnf check-update
		sudo dnf install code
	fi

	return 0
}

function cleanUp() {
    sudo dnf -y autoremove

    return 0
}

function softwareEnabling() {
    sudo systemctl enable sshd
    sudo systemctl enable tlp
    sudo systemctl enable firewalld
	sudo systemctl enable nginx
    
    return 0
}

function

# script driver
function main() {
	# hostname # broken
    updates
    softwareInstalls
    softwareEnabling
    cleanUp

	echo "Fedora Workstaton 29 postbuild is complete."

	read -p "Restart required, do this now? [Y/n]: " -r
	if [[ "$REPLY" =~ ^[nN] ]]; then
		echo "Please restart this workstation ASAP to prevent performance issues."
	else
		sudo reboot
	fi

	return 0
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "Warning: exiting w/ status $___status___"
fi

exit $___status___ || return $___status___