#!/bin/bash

set -e

echo "Configuring WordPress..."

# Start MariaDB
systemctl enable mariadb
systemctl start mariadb

# Create WordPress database and user
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "CREATE USER IF NOT EXISTS 'wordpressuser'@'localhost' IDENTIFIED BY '<REDACTED_PASSWORD>';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Clean the web directory
rm -rf /var/www/html/*

# Download WordPress
cd /tmp
rm -f latest.tar.gz
curl -L https://wordpress.org/latest.tar.gz -o latest.tar.gz

# Extract WordPress
tar -xzf latest.tar.gz

# Copy WordPress files
cp -R wordpress/* /var/www/html/

# Create wp-config.php
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
sed -i "s/username_here/wordpressuser/" /var/www/html/wp-config.php
sed -i "s/password_here/<REDACTED_PASSWORD>/" /var/www/html/wp-config.php

# Set permissions
chown -R apache:apache /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

echo "WordPress configuration completed."
