#!/bin/bash

wrkPath="./.testTmp"
mkdir $wrkPath
default=1

if [[ $1 == "default" ]]; then
    default=0
fi

if [ $default -ne 0 ]; then
    read -p "enter y or Y: " -n 1 -r
    echo
    thisIn=$REPLY
    if [[ $thisIn =~ ^[Yy] ]]; then
        echo "Buckle up, kids."
    fi
fi

[[ -d $wrkPath ]] && rm -rf $wrkPath

exit 0
