server {

    server_name         alzie.pavshelpdesk.com;
    access_log          /var/log/nginx/alzie.pavshelpdesk.com.access.log;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://alzie; # redirects to load balancer in nginx.conf
        #proxy_pass http://127.0.0.1:43210/; # emergency option in case load balancer fails

        proxy_ssl_session_reuse off;
    }



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/alzie.pavshelpdesk.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/alzie.pavshelpdesk.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = alzie.pavshelpdesk.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header Connection "";

    server_name         alzie.pavshelpdesk.com;
    listen 80;
    return 404; # managed by Certbot

}
