server {
    listen 3200;
    listen [::]:3200;

    root /var/www/example.com/html;
    index index.html;
    error_page 404 /404.html;

    server_name www.example.com;

    location / {
        proxy_pass http://localhost:3400/;
    }
}

