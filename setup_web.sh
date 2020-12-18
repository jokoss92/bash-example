#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install nginx nginx-fpm unzip wget mysql-server php php-mysql -y
 echo "Download web data"
 sudo cd /var/www/html/ && sudo wget https://github.com/sdcilsy/sosial-media/archive/master.zip 
 echo "Ekstrak file"
 unzip master.zip
 echo "Memindahkan data"
 #sudo rm /var/www/html/*
 #sudo rm -R /var/www/html/*
 sudo mv sosial-media-master/* /var/www/html
 echo "Config file"
 sudo mv pesbuk /etc/nginx/sites-available/ 
 sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
 sudo unlink /etc/nginx/sites-enabled/default
 echo "Enable service"
 sudo systemctl restart nginx
 sudo systemctl enable nginx
 echo "Setup selesai"
 exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
