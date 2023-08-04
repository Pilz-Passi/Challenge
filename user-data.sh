###############################################
#
# author: Pascal Spielvogel
#
# purpose of this script:
# - To install all neccecary tools for setting up a web server.
# - Fetch content for Wordpress from S3 bucket
# - Provide MySQL client
# - Connect Wordpress with RDS database
#
################################################

#!/bin/bash

#update any preinstalled packages, just to make sure.
sudo yum update -y
#install Apache Web Server, Maria Database and php Database
sudo yum install -y httpd php mariadb105-server
sudo yum install -y php-mysqli
#install EPEL
sudo amazon-linux-extras install -y epel
#may it might be possible to install a new php
#sudo amazon-linux-extras install -y php8.2
#install repo
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
#enable php8.0, clean meta and install package
sudo amazon-linux-extras enable php8.0
sudo yum clean metadata
sudo yum install -y php-cli php-pdo php-fpm php-json php-mysqlnd php php-{mbstring,json,xml,mysqlnd}
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
#searches for all files in the /var/www directory and its subdirectories, and then it sets the permissions so the owner can read and write, while the group and others can only read the file
find /var/www -type f -exec sudo chmod 0664 {} \;
#this command didn't work on manual approach, so I hashed it for now.
#sudo chkconfig httpd on
#start Mariadb Service
sudo systemctl start mariadb
#Enable it, so it starts automatically after a reboot
sudo systemctl enable mariadb
#writing permission for the config file in order to configure wordpress
#sudo chmod 744 /var/www/html

# Copy Wordpress homepage from S3 bucket
cd /var/www/html
aws s3 sync s3://deham6-wordpress/ .

# # Optional: Installing Wordpress from scratch

# #Creating a Database in Mysql
# sudo mysql -e "CREATE DATABASE mydb /*\!40100 DEFAULT CHARACTER SET utf8 */;"
# #Creating a user named "default_user" with the password "password123"
# sudo mysql -e "CREATE USER default_user@localhost IDENTIFIED BY 'password123';"
# #Grant that user all the privileges 
# sudo mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'default_user'@'localhost';"
# #apply these privileges
# sudo mysql -e "FLUSH PRIVILEGES;"

# #download wordpress
# wget https://wordpress.org/latest.tar.gz
# #move it to that folder
# sudo mv latest.tar.gz /var/www/html
# #navigate to that folder
# cd /var/www/html
# #extract the wordpress files
# tar -xzf latest.tar.gz
# #move the extracted files to the root directory
# sudo mv -f wordpress/* ./

#in order to automate the conifguration of worpress, the following lines will have to be added at some point
#copy the sample file, to be the new config
#sudo cp wp-config-sample.php wp-config.php
#Replace database details in wp-config.php, using the credentials I used before for the mysql. see above.
sudo sed -i "s/database_name_here/${DB}/g" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${User}/g" /var/www/html/wp-config.php
sudo sed -i "s/password_here/${PW}/g" /var/www/html/wp-config.php
sudo sed -i "s/localhost/${host}/" wp-config.php

#restart Apache Web Server Service
sudo systemctl restart httpd

# #install stresstest module for testing purposes later
# wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1-23732/174-lab-JAWS-scale-load-balance/s3/loadtestapp.zip
# unzip loadtestapp.zip -d /var/www/html/
