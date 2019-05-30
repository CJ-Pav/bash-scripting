#!/bin/sh
# Filename: backup-user-profiles.sh
# Author: Chris Pavlovich
# Edited: Apr 17, 2019
# Description: Backup user profiles with rsync; tested with Fedora 29 and Manjaro


# gather user names and prompt
function init() {
    # variable declarations
    userToBackup=""
    # store home profiles in string
    userNames="$(sudo ls /home/)"

    # check for temp file storage & create if not found
    if [ ! -d "/home/$USER/.tmp_backup_logs" ]; then
        mkdir ~/.tmp_backup_logs
        if [ ! -d "/home/$USER/.tmp_backup_logs" ]; then 
            echo "ERROR: /home/$USER/.tmp_backup_logs not created." >&2
            return 1
        fi
    fi

    # if [ $_defaults_ -eq 1 ]; then

    # print available user profiles (even if user has been removed)
    touch /home/$USER/.tmp_backup_logs/avail_users_$$
    for eachUser in $userNames; do
        printf "$eachUser " >> /home/$USER/.tmp_backup_logs/avail_users_$$
    done
    printf "Users available: "; cat /home/$USER/.tmp_backup_logs/avail_users_$$; echo

    # prompt for user to backup until input received
    while [ -z "$userToBackup" ]; do
        echo "Enter name of user to backup, or 'all'."
        read -p "User to backup: " userToBackup
    done

    echo "$userToBackup" > /home/$USER/.tmp_backup_logs/user_to_backup_$$

    return 0
}

function validate() {
    #variable declarations
    userExists=1

    # read user to backup
    userToBackup="$(cat /home/$USER/.tmp_backup_logs/user_to_backup_$$)"

    # validate user profile(s)
    if [[ "$userToBackup" == "all" ]]; then
        echo; echo "Prepping to backup all user profiles..."
    else
        # verify user has a profile
        for eachUser in /home/$USER/.tmp_backup_logs/avail_users_$$; do
            [[ "$userToBackup" == "$eachUser" ]] && userExists=0
        done
        if [ $userExists -ne 0 ]; then
            if [ -d /home/$userToBackup ]; then
                userExists=0
            else
                # error & exit
                echo "ERROR: user profile not found." >&2
                return 1;
            fi
        fi
        if [ $userExists -eq 0 ]; then
            echo; echo "Prepping to backup user $userToBackup's profile..."
        fi
    fi

    return 0
}

# backup specified user(s)
function backupUserProfiles() {
    # verify user profile exists
    validate

    if [ $? -ne 0 ]; then
        echo "ERROR: validate() returned non-zero status."
        return 1
    fi

    # double check valid input
    if [ -d /home/$userToBackup ] || [[ "$userToBackup" == "all" ]]; then
        # start backup(s)
        read -p "Back up to local or remote location? [local/remote]: " backupLocation
        if [[ "$backupLocation" == "local" ]]; then
            read -p "Enter path to backup location (ex. /mnt/backups/users/): " backupPath
            if [ -d "$backupPath" ]; then
                if [[ "$userToBackup" == "all" ]]; then
                    # backup all users
                    for eachUser in /home/$USER/.tmp_backup_logs/avail_users_$$; do
                        echo "Backing up user $eachUser's profile..."
                        sudo rsync -azvh /home/* $backupPath
                    done
                else # back up specified user
                    sudo rsync -azvh /home/$userToBackup $backupPath
                fi
            fi
        elif [[ "$backupLocation" == "remote" ]]; then
            read -p "Enter the IPv4 address or domain of the server you want to backup to: " ipAddress
            read -p "Enter path to backup location (ex. /mnt/backups/users/): " backupPath
            # check if trailing / is missing and add
            if [[ "$userToBackup" == "all" ]]; then
                # backup all users
                for eachUser in /home/$USER/.tmp_backup_logs/avail_users_$$; do
                    sudo rsync -azvh /home/$eachUser $USER@$ipAddress:$backupPath$eachUser
                done
            else # back up specified user
                sudo rsync -azvh /home/$userToBackup $USER@$ipAddress:$backupPath
            fi
        fi
    else
        # error & exit
        echo "ERROR: directory /home/$userToBackup not found."
        return 1
    fi

    return 0
}

# remove temporary files
function cleanTmpLogs() {
    rm -rf /home/$USER/.tmp_backup_logs

    # prompt to make sure they deleted
    if [ -d "/home/$USER/.tmp_backup_logs" ]; then
        read -p "Force removal of temp logs? [Y/n]: " -r
        if [[ ! "$REPLY" =~ ^[nN] ]]; then
            sudo rm -rf /home/$USER/.tmp_backup_logs
        else
            echo "ERROR: tmp files not deleted." >&2
            echo "Manually delete /home/$USER/.tmp_backup_logs"
            return 1
        fi
    fi

    return 0
}

# script driver
function main() {
    # variable declarations
    ___status___=0

    # show that something is happening
    echo; echo "Initializing..."
    init

    # backup user stored in 'userToBackup'
    if [ $? -eq 0 ]; then
        backup; ___status___=$?
    else
        echo "Error: initialization failed, non-zero status."
    fi

    cleanTmpLogs
    
    return $___status___
}

main; ___status___=$?

if [ $___status___ -ne 0 ]; then
    echo "WARN: exiting with non-zero status ($___status___)"
fi

exit $___status___ || return $___status___
