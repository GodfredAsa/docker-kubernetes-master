FROM composer:latest
WORKDIR /var/www/html
# bcos of the entrypoint commands thats we created the dockerfile
ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]