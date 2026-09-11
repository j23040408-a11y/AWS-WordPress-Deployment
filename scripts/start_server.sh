#!/bin/bash

set -e

echo "Starting Apache and PHP-FPM..."

systemctl enable httpd
systemctl enable php-fpm

systemctl start php-fpm
systemctl start httpd

echo "Apache and PHP-FPM started successfully."
