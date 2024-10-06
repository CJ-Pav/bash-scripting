#!/bin/bash

__selection__=""
___status___=0



# web server installer
function web_server_installer() {
    escape=1
    while [ $escape -ne 0 ]; do
        echo "Which web application to launch?"
        cat /home/ptech/bash-scripting/ptech/menu/web_domain_menu; echo
        read -p "Selection (#): " __selection__
        if [ $__selection__ -eq 0 ]; then
            # exit
            escape=0
        elif [ $__selection__ -eq 1 ]; then
            echo "Installing legacy apps..."

            # install legacy.pavshelpdesk.com on port 3000
            echo "Installing legacy.pavshelpdesk.com on port 3000"
            sudo su -c 'cd /home/ptech/bash-scripting/ptech/legacy-web-apps/project-help-desk-legacy/ && docker compose up --build -d'
            escape=0
        elif [ $__selection__ -eq 2 ]; then
            echo "Installing pavshelpdesk.com on port 3001"
            git clone git@github.com:CJ-Pav/project-help-desk.git /home/ptech/project-help-desk
            sudo su -c 'cd /home/ptech/project-help-desk && docker compose up --build -d'

            echo "Installing pavlovichtechnologies.com on port 3002"
            git clone git@github.com:Bytephyte/project-pav-tech-home-page.git /home/ptech/project-bytephyte-home-page/
            sudo su -c 'cd /home/ptech/project-pav-tech-home-page/ && docker compose up --build -d'

            # echo "Installing bytephyte.com on port 3002"
            # git clone git@github.com:Bytephyte/project-bytephyte-homepage.git /home/ptech/project-bytephyte-home-page/
            # sudo su -c 'cd /home/ptech/project-bytephyte-home-page/ && docker compose up --build -d'

            escape=0
        elif [ $__selection__ -eq 3 ]; then
            echo "Installing alzie.com on port 43210"
            git clone git@github.com:bytephyte/project-alzie.git /home/ptech/project-alzie
            sudo su -c 'cd /home/ptech/project-alzie && docker compose up --build -d'
            escape=0
        else
            echo "This option is not yet available."
        fi
    done
    escape=1

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
            # reinstall legacy.pavshelpdesk.com on port 3000
            sudo su -c 'cd /home/ptech/bash-scripting/ptech/legach-web-apps/ && docker compose down; docker compose up --build -d'
        elif [ $__selection__ -eq 2 ]; then
            echo "Reinstalling pavshelpdesk.com on port 3001."
            sudo rm -rf /home/ptech/project-help-desk/
            git clone git@github.com:CJ-Pav/project-help-desk.git /home/ptech/project-help-desk
            sudo su -c 'cd /home/ptech/project-help-desk && docker compose down; docker compose up --build -d'

            echo "Reinstalling pavlovichtechnologies.com on port 3002"
            git clone git@github.com:Bytephyte/project-pav-tech-home-page.git /home/ptech/project-pav-tech-home-page/
            sudo su -c 'cd /home/ptech/project-pav-tech-home-page/ && docker compose up --build -d'

            # echo "Reinstalling bytephyte.com on port 3003."
            # git clone git@github.com:Bytephyte/project-bytephyte-homepage.git /home/ptech/project-bytephyte-home-page/
            # sudo su -c 'cd /home/ptech/project-bytephyte-home-page/ && docker compose up --build -d'

        elif [ $__selection__ -eq 3 ]; then
            echo "Reinstalling alzie.com on port 43210"
            sudo rm -rf /home/ptech/customers/project-alzie
            git clone git@github.com:bytephyte/project-alzie.git /home/ptech/customers/project-alzie
            sudo su -c 'cd /home/ptech/customers/project-alzie && docker compose up --build -d'
        else
            echo "This option is not yet enabled."
        fi
    done
    escape=1

    return $___status___
}

# configure reverse proxy and load balancer menu
function config_reverse_proxy_menu() {
    escape=1
    while [ $escape -ne 0 ]; do
        # Get the hostname of the system
        HOSTNAME=$(hostname)

        # Copy load balancer config based on the hostname
        # Required due to IP address changes on each config
        case "$HOSTNAME" in
        "ptech-server-2")
            echo "Performing actions for server2..."
            sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-2-nginx.conf /etc/nginx/nginx.conf
            ;;
        "ptech-server-3")
            echo "Performing actions for server3..."
            sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-3-nginx.conf /etc/nginx/nginx.conf
            ;;
        "cjpavlovich-HP-Pavilion-m6-Notebook-PC")
            echo "Performing actions for server4..."
            sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-4-nginx.conf /etc/nginx/nginx.conf
            ;;
        *)
            echo "Error: hostname not recognized."
            exit 1
            ;;
        esac

        echo "Configure reverse proxy for which web application?"
        cat /home/ptech/bash-scripting/ptech/menu/web_domain_menu; echo
        read -p "Selection (#): " __selection__
        
        case "$__selection__" in
            "0")
                # exit
                escape=0
                ;;
            "1")
                # copy nginx sites-available configs
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/legacy.pavshelpdesk.com /etc/nginx/sites-available/legacy.pavshelpdesk.com

                # create sym links FOR EACH PAGE
                sudo ln -s /etc/nginx/sites-available/legacy.pavshelpdesk.com /etc/nginx/sites-enabled/legacy.pavshelpdesk.com

                # restart nginx service
                sudo systemctl restart nginx

                # enable tls encryption with lets encrypt certificate
                read -p "Enabling TLS encryption. Press any key to continue." -r -n 1
                sudo certbot --nginx legacy.pavshelpdesk.com

                # copy post config, requires certificate have the expected name
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/post-tls-legacy.pavshelpdesk.com /etc/nginx/sites-available/legacy.pavshelpdesk.com

                escape=0
                ;;
            "2")
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/pavshelpdesk.com /etc/nginx/sites-available/pavshelpdesk.com
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/pavlovichtechnologies.com /etc/nginx/sites-available/pavlovichtechnologies.com
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/bytephyte.com /etc/nginx/sites-available/bytephyte.com

                sudo ln -s /etc/nginx/sites-available/pavshelpdesk.com /etc/nginx/sites-enabled/pavshelpdesk.com
                sudo ln -s /etc/nginx/sites-available/pavlovichtechnologies.com /etc/nginx/sites-enabled/pavlovichtechnologies.com
                sudo ln -s /etc/nginx/sites-available/bytephyte.com /etc/nginx/sites-enabled/bytephyte.com

                # restart nginx service
                sudo systemctl restart nginx

                # enable tls encryption with lets encrypt certificate
                read -p "Enabling TLS encryption. Press any key to continue." -r -n 1

                echo "code incomplete exiting non zero."; exit 1
                sudo certbot --nginx pavshelpdesk.com
                sudo certbot --nginx pavlovichtechnologies.com

                # copy post config, requires certificate have the expected name
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/post-tls-legacy.pavshelpdesk.com /etc/nginx/sites-available/legacy.pavshelpdesk.com
                ;;
            "3")
                sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/alzie.com /etc/nginx/sites-available/alzie.com
                sudo ln -s /etc/nginx/sites-available/alzie.com /etc/nginx/sites-enabled/alzie.com
                ;;
        esac
        # if [ $__selection__ -eq 0 ]; then
        #     # exit
        #     escape=0
        # elif [ $__selection__ -eq 1 ]; then
        #     # install pavshelpdesk.com on port 3001
        #     # git clone git@github.com:CJ-Pav/project-help-desk.git /home/ptech/project-help-desk
        #     # sudo su -c 'cd /home/ptech/project-help-desk && git checkout 23-remodel && docker compose up -d'
            
        #     # copy nginx configs
        #     sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/legacy.pavshelpdesk.com /etc/nginx/sites-available/legacy.pavshelpdesk.com
        #     sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/pavshelpdesk.com /etc/nginx/sites-available/pavshelpdesk.com
        #     sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/pavlovichtechnologies.com /etc/nginx/sites-available/pavlovichtechnologies.com
        #     sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/bytephyte.com /etc/nginx/sites-available/bytephyte.com

        #     # Get the hostname of the system
        #     HOSTNAME=$(hostname)

        #     # Perform actions based on the hostname
        #     case "$HOSTNAME" in
        #     "ptech-server-2")
        #         echo "Performing actions for server2..."
                
        #         sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-2-nginx.conf /etc/nginx/nginx.conf
        #         ;;
        #     "ptech-server-3")
        #         echo "Performing actions for server3..."

        #         sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-3-nginx.conf /etc/nginx/nginx.conf
        #         # Add commands specific to server3 here
        #         ;;
        #     "ptech-server-4")
        #         echo "Performing actions for server4..."

        #         sudo cp /home/ptech/bash-scripting/ptech/nginx/ptech-server-4-nginx.conf /etc/nginx/nginx.conf
        #         ;;
        #     *)
        #         echo "Error: hostname not recognized."
        #         exit 1
        #         ;;
        #     esac

        #     # create sym links FOR EACH PAGE
        #     sudo ln -s /etc/nginx/sites-available/pavshelpdesk.com /etc/nginx/sites-enabled/pavshelpdesk.com

        #     # restart nginx service
        #     sudo systemctl restart nginx

        #     # enable tls encryption with lets encrypt certificate
        #     read -p "Enabling TLS encryption. Press any key to continue." -r -n 1
        #     sudo certbot --nginx

        #     # copy post config, requires certificate have the expected name
        #     sudo cp /home/ptech/bash-scripting/ptech/nginx/sites-available/post-tls-pavshelpdesk.com /etc/nginx/sites-available/pavshelpdesk.com

        #     escape=0
        # else
        #     echo "This option is not yet available."
        # fi
    done
    escape=1

    return $___status___
}

# web server management
function web_server_management() {
    escape=1
    __selection__=1
    while [ $escape -ne 0 ]; do
        echo; cat /home/ptech/bash-scripting/ptech/menu/web_man_menu; echo
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
        elif [ $__selection__ -eq 5 ]; then
            # add nginx conf files and configure tls encryption for the domain
            config_reverse_proxy_menu; ___status___=$?
            if [ $___status___ -ne 0 ]; then
                # error
                echo "Warning: reverse proxy setup exited with error status."
            fi
        fi
    done
    escape=1

    return $___status___
}
