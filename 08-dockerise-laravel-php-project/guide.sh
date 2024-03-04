# TO CREATE LARAVEL APPLICATION THROUGH COMPOSER LOOK AT THE LARAVEL OFFICIAL DOCS 
# run the composer service to create laravel project 
docker-compose run --rm composer create-project --prefer-dist laravel/laravel  .

# After generating the project starter codes 
# we need to open the .env file and make changes to the default db configuration to work with our docker containers by using the values we setup for launching mysql container.
# NB: HOST_NAME should be the mysql container name 

docker-compose up -d server php mysql 

# after using server service depending on mysql and php 
- use this to start up 
docker-compose up -d server

# force rebuild 
docker-compose up -d --build server 

# after configuring the artisan service, writes data to the db and checks the connection as 
docker-compose run --rm artisan migrate


- to run the project 

docker-compose build 
docker-compose up 

=========================== CONTAINERIZING PHP AND LARAVEL PROJECT ====================
With the aid of examples give a step by step guide to containerizing php laravel project using mysql with using Dockerfile and docker-compose 
ChatGPT
Sure, I can guide you through the process of containerizing a PHP Laravel project with MySQL using Dockerfile and docker-compose. Here's a step-by-step guide with examples:

Setup Your Laravel Project:
Start by having a Laravel project ready. You can create a new one or use an existing project.

Create a Dockerfile:
Create a file named Dockerfile in the root directory of your Laravel project. This file will contain instructions for building your PHP container.

===================     Dockerfile    ====================
FROM php:7.4-fpm

# Set the working directory in the container
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install zip pdo pdo_mysql

# Copy the local Laravel files to the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install

# Expose port 9000 to the outside world
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]

====================================================================================
Create a docker-compose.yml File:
Create a docker-compose.yml file in the root directory of your project. This file will define the services needed for your application, including PHP and MySQL.

====================== docker-compose.yml file =====================
version: '3'
services:
  php:
    build: .
    ports:
      - "9000:9000"
    volumes:
      - .:/var/www/html
    depends_on:
      - mysql
  mysql:
    image: mysql:5.7
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: laravel
      MYSQL_USER: laravel
      MYSQL_PASSWORD: secret
    volumes:
      - mysql_data:/var/lib/mysql
volumes:
  mysql_data:
  =======================================================
Build and Run the Containers:
Open a terminal in the root directory of your project and run the following command:

css
Copy code
docker-compose up --build
This command will build the Docker containers defined in the docker-compose.yml file and start them.

Access Your Laravel Application:
Once the containers are up and running, you can access your Laravel application by visiting http://localhost:9000 in your web browser.

That's it! You now have a PHP Laravel project containerized with MySQL using Dockerfile and docker-compose. You can further customize the Dockerfile and docker-compose.yml file according to your project's requirements.




