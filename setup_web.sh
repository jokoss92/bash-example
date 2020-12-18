#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install nginx php-fpm unzip wget mysql-server php-mysql -y
 sudo rm /var/www/html/*
 sudo rm -R /var/www/html/*
 echo "Download web data"
 sudo wget https://github.com/sdcilsy/sosial-media/archive/master.zip  
 echo "Ekstrak file"
 sudo unzip master.zip
 echo "Memindahkan data"
 sudo mv sosial-media-master/* /var/www/html/
 echo "Config file"
 sudo unlink /etc/nginx/sites-enabled/default
 sudo unlink /etc/nginx/sites-enabled/pesbuk
 sudo cp pesbuk /etc/nginx/sites-available/ 
 sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
 echo "Enable service"
 sudo systemctl restart nginx
 sudo systemctl enable nginx
 echo "Setup selesai"
 exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
