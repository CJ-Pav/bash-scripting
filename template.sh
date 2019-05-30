#!/bin/sh
# Filename: format.sh
# Author: Chris Pavlovich
# Edited: Apr 15, 2019
# Description: general use bash script format

# variable declarations
___status___=0

# description
function myFunction() {
    # do something
    echo "Hello World!"

    return 0
}

# script driver
function main() {
    myFunction; ___status___=$?
    
    return $___status___
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "WARN: exiting with non-zero status ($___status___)"
fi

exit $___status___ || return $___status___
