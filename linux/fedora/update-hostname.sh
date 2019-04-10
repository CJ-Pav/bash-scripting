#!/bin/bash

# var init
__status__=0
_hostname_="$(cat /etc/hostname)"

# check if run as root
if [ $UID -ne 0 ]; then
    # throw error and exit
    echo "error: root permissions required" >&2
    __status__=1
else
    # prompt for new hostname
    read -p "Enter a new hostname: " _updated_hostname_
    echo "$_updated_hostname_" > /etc/hostname

    # confirm hostname was properly set
    _confirmation_="$(cat /etc/hostname)"
    if [[ "$_updated_hostname_" == "$_confirmation_" ]]; then
        __status__=0
    else
        __status__=2
    fi
fi

echo -e "Hostname set to $_updated_hostname_."

exit $__status__
