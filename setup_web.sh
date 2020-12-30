#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install nginx php-fpm unzip wget mysql-server php-mysqli -y
 echo "Delete default html"
 sudo rm -rf /var/www/html/*
 echo "Download web data"
 cd /var/www/html/ && sudo git clone https://github.com/jokoss92/sosial-media && 
 ##sudo wget https://github.com/sdcilsy/sosial-media/archive/master.zip && sudo unzip master.zip && 
 sudo mv sosial-media/* /var/www/html/
 echo "Config file"
 sudo unlink /etc/nginx/sites-enabled/default
 sudo unlink /etc/nginx/sites-enabled/pesbuk 
 sudo cp ~/bash-example/pesbuk /etc/nginx/sites-available/ 
 sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
 echo "Enable service"
 sudo nginx -t
 sudo systemctl restart nginx
 sudo systemctl enable nginx
 echo "Setting db"
sudo mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS dbsosmed;
CREATE USER IF NOT EXISTS 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';
GRANT ALL PRIVILEGES ON * . * TO 'devopscilsy'@'localhost';
FLUSH PRIVILEGES;
EOF
 echo "Setup selesai"
# exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
