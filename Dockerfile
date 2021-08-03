# syntax=docker/dockerfile:1
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install ansible nano
WORKDIR /
# Create folders for both www.example.com and localhost
RUN mkdir -p /var/www/www.example.com/html /var/www/localhost/html /var/www/error
RUN chown -R $USER:$USER /var/www/www.example.com/html /var/www/localhost/html /var/www/error
RUN chmod -R 755 /var/www
# Perform wildcard copy of all files
COPY . .
RUN ansible-playbook nginx.yaml
RUN ln -sf /var/www/error/404.html /var/www/www.example.com/html/404.html
RUN ln -sf /var/www/error/404.html /var/www/localhost/html/404.html
EXPOSE 3200
STOPSIGNAL SIGTERM
#CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]
