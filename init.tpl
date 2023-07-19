#!/bin/bash

sudo yum update -y
sudo yum install -y httpd mariadb mariadb-server mysql mysql-server php php-mysqlnd
#sudo wget php-fpm php-mysqli php-json php php-devel
#sudo mysql_secure_installation -
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
find /var/www -type f -exec sudo chmod 0664 {} \;
#sudo chkconfig httpd on
sudo systemctl start mariadb
sudo systemctl enable mariadb
#writing permission for the config file in order to configure wordpress
sudo chmod 744 /var/www/html

sudo mysql -e "CREATE DATABASE mydb /*\!40100 DEFAULT CHARACTER SET utf8 */;"
sudo mysql -e "CREATE USER default_user@localhost IDENTIFIED BY 'password123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'default_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

wget https://wordpress.org/latest.tar.gz
sudo mv latest.tar.gz /var/www/html
cd /var/www/html
tar -xzf latest.tar.gz
sudo mv -f wordpress/* ./
sudo systemctl restart httpd