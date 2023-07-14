#!/bin/bash

sudo yum update -y
sudo yum install -y httpd mariadb-server php php-mysqlnd
sudo yum install -y wget php-fpm php-mysqli php-json php php-devel
sudo systemctl start mariadb
sudo mysql_secure_installation
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mysql -u root -p
CREATE USER 'monty'@'localhost' IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES ON mydb.* TO 'monty'@'localhost';
quit