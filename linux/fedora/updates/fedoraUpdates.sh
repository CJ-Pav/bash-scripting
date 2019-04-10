#!/bin/bash
# run/config updates (fedora)

_option_="0"
_response_="0"

echo "Would you like to force all updates or receive a prompt?"
echo " 1: Force all available updates"
echo " 2: Prompt before applying updates"
read -p "Enter the number of your choice: " -n 1 _response_

while [[ "$_option_" == "0" ]]; do
	if [[ "$_response_" =~ ^[1] ]]; then
		_option_="-y"
	elif [[ "$_response_" =~ ^[2] ]]; then
		_option_=""
	else
		_option_=""
	fi
done

# this will require elevated permissions
sudo dnf $_option_ update
sudo dnf $_option_ upgrade
sudo dnf $_option_ autoremove

# prompt and exit on [N/n]
read -p "Reboot now? [Y/n]: " -n 1 -r
if [[ $REPLY =~ ^[Nn] ]]; then
	echo "I too like to live dangerously..." >&2
	exit 1
else
	echo "Restarting..."
	sudo reboot now
fi

exit 0
