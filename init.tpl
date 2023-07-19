#!/bin/bash

#update any preinstalled packages, just to make sure.
sudo yum update -y
#install a bunsh of php stuff that we may or may not use and find suitable. Basically I collected all lines of code I could find from the cohert.
sudo yum install -y httpd mariadb mariadb-server mysql mysql-server php php-mysqlnd php-mysqli php-json php-fpm
#as the following lines gave out an error, I hashed them.
#sudo wget php-fpm php-mysqli php-json php php-devel
#sudo mysql_secure_installation
#Start Apache Web Server
sudo systemctl start httpd
#Enable it, so it starts automatically after a reboot
sudo systemctl enable httpd
#Create a user named "ec2-user" on the Apache Web Server
sudo usermod -a -G apache ec2-user
#transmit ownership of this folder to the ec2-user
sudo chown -R ec2-user:apache /var/www
#I don't know what the fuck this command does. May set writing permissions to that directory. (same as below)
find /var/www -type f -exec sudo chmod 0664 {} \;
#this command didn't work on manual approach, so I hashed it for now.
#sudo chkconfig httpd on
#start Mariadb Service
sudo systemctl start mariadb
#Enable it, so it starts automatically after a reboot
sudo systemctl enable mariadb
#writing permission for the config file in order to configure wordpress
sudo chmod 744 /var/www/html

#Creating a Database in Mysql
sudo mysql -e "CREATE DATABASE mydb /*\!40100 DEFAULT CHARACTER SET utf8 */;"
#Creating a user named "default_user" with the password "password123"
sudo mysql -e "CREATE USER default_user@localhost IDENTIFIED BY 'password123';"
#Grant that user all the privileges 
sudo mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'default_user'@'localhost';"
#apply these privileges
sudo mysql -e "FLUSH PRIVILEGES;"

#download wordpress
wget https://wordpress.org/latest.tar.gz
#move it to that folder
sudo mv latest.tar.gz /var/www/html
#navigate to that folder
cd /var/www/html
#extract the wordpress files
tar -xzf latest.tar.gz
#move the extracted files to the root directory
sudo mv -f wordpress/* ./
#restart Apache Web Server Service
sudo systemctl restart httpd

#in order to automate the conifguration of worpress, the following lines will have to be added at some point
# Replace database details in wp-config.php
#sudo sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
#sudo sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
#sudo sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php