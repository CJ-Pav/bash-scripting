
server {

    server_name         alzie.pavshelpdesk.com;
    access_log          /var/log/nginx/alzie.com.access.log;


    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://127.0.0.1:43210/;

        proxy_ssl_session_reuse off;
        #proxy_set_header Upgrade $http_upgrade;
        #proxy_set_header Host $host;
        #proxy_cache_bypass $http_upgrade;
    }

}