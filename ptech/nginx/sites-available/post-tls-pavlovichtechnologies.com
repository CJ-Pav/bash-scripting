server {

    server_name         pavlovichtechnologies.com;
    access_log          /var/log/nginx/pavlovichtechnologies.com.access.log;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://ptech; # redirects to load balancer in nginx.conf
        #proxy_pass http://127.0.0.1:3002/; # emergency option in case load balancer fails

        proxy_ssl_session_reuse off;
    }



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/pavlovichtechnologies.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/pavlovichtechnologies.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = pavlovichtechnologies.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header Connection "";

    server_name         pavlovichtechnologies.com;
    listen 80;
    return 404; # managed by Certbot


}
