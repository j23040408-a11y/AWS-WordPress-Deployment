#!/bin/bash

echo "Stopping Apache and PHP-FPM..."

systemctl stop httpd || true
systemctl stop php-fpm || true

echo "Apache and PHP-FPM stopped."
