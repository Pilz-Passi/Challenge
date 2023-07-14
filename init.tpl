#!/bin/bash

echo "CONSUL_ADDRESS = ${consul_address}" > /tmp/iplist
sudo yum update -y",
sudo yum install -y nginx,
sudo service nginx start
sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
sudo dnf install mariadb105-server
sudo systemctl start mariadb
sudo mysql_secure_installation
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz