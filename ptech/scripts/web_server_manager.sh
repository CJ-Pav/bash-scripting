#!/bin/bash

__selection__=""
___status___=0



# web server installer
function web_server_installer() {
    escape=1
    while [ $escape -ne 0 ]; do
        cat /home/ptech/bash-scripting/ptech/menu/web_domain_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            # install pavshelpdesk.com on port 3001
            git clone git@github.com:CJ-Pav/project-help-desk.git /home/ptech/project-help-desk
            sudo su -c 'cd /home/ptech/project-help-desk && git checkout 23-remodel && docker compose up -d'
        fi
    done
    return $___status___
}

# web server config update
function web_server_update() {
    escape=1
    while [ $escape -ne 0 ]; do
        echo "Which web config to update?"
        cat /home/ptech/bash-scripting/ptech/menu/web_domain_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            # reinstall pavshelpdesk.com on port 3001
            rm -rf /home/ptech/project-help-desk/
            git clone git@github.com:CJ-Pav/project-help-desk.git /home/ptech/project-help-desk
            sudo su -c 'cd /home/ptech/project-help-desk && git checkout 23-remodel && docker compose down; docker compose up -d'
        else
            echo "This option is not yet enabled."
        fi
    done
    return $___status___
}

# web server management
function web_server_management() {
    escape=1
    __selection__=1
    while [ $escape -ne 0 ]; do
        echo; echo "Please select an option below."
        cat ./ptech/menu/web_man_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq -1 ]; then
            # error
            echo "Warning: admin utility exited with error status."
        elif [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            # view status
            read -p "Nginx proxy status (any key to continue)..." -r -n 1
            systemctl status nginx
            read -p "Docker image status (any key to continue)..." -r -n 1
            sudo docker ps
        elif [ $__selection__ -eq 2 ]; then
            # install web server config
            web_server_installer; ___status___=$?
            if [ $___status___ -ne 0 ]; then
                # error
                echo "Warning: web server installer exited with error status."
            fi
        elif [ $__selection__ -eq 3 ]; then
            # update web server configuration
            web_server_update; ___status___=$?
            if [ $___status___ -ne 0 ]; then
                # error
                echo "Warning: web server update exited with error status."
            fi
        fi
    done
    return $___status___
}
