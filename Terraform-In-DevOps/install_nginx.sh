#!/bin/bash

sudo apt-get update
sudo apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

echo "<h1> Here Nginx installation and running </h1>" | sudo tee /var/www/html/index.html > /dev/null
