#!/bin/bash

set -e

echo "Installing Apache, PHP, MariaDB and required packages..."

dnf update -y

dnf install -y \
    httpd \
    mariadb105-server \
    php \
    php-mysqlnd \
    php-fpm \
    php-gd \
    php-mbstring \
    php-xml \
    php-cli \
    unzip \
    wget

echo "Dependencies installed successfully."
