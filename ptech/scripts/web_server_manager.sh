#!/bin/bash

__selection__=""
___status___=0

# web server installer
function web_server_installer() {
    escape=1
    while [ escape -ne 0 ]; do
        cat ./ptech/menu/web_srv_install_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            # install pavshelpdesk.com on port 3001
            git clone git@github.com:CJ-Pav/project-help-desk.git
            pwd > /home/ptech/
            sudo su -C "cd "
        fi
    done
    return $___status___
}

# web server management
function web_server_management() {
    escape=1
    while [ escape -ne 0 ]; do
        cat ./ptech/menu/web_man_menu; echo
        read -p "Selection (#): " -r
        if [ $___status___ -eq -1 ]; then
            # error
            echo "Warning: admin utility exited with error status."
        elif [ $___status___ -eq 0 ]; then
            # exit
            escape=0
        elif [ $___status___ -eq 1 ]; then
            # view status
            read -p "Nginx proxy status (any key to continue)..." -r -n 1
            systemctl status nginx
            read -p "Docker image status (any key to continue)..." -r -n 1
            sudo docker ps
        elif [ $___status___ -eq 2 ]; then
            # install web server config
            web_server_installer; ___status___=$?
            if [ $___status___ -ne 0 ]; then
                # error
                echo "Warning: web server installer exited with error status."
            fi
        fi
    done
    return $___status___
}
