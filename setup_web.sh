#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver" 
 sudo apt-get install nginx php-fpm unzip wget php-mysqli -y
 echo "Delete default html"
 sudo rm -rf /var/www/html/*
 echo "Download web data"
 cd /var/www/html/ && sudo git clone https://github.com/jokoss92/sosial-media.git && 
 sudo mv sosial-media/* /var/www/html/ && sudo mv sosial-media/.[!.]* /var/www/html/
 sudo sed -i 's/$db_host = "localhost";/$db_host = "172.31.16.217";/g' /var/www/html/config.php 
 echo "Set git workflow"
 sudo git remote add upstream https://github.com/sdcilsy/sosial-media.git && sudo git fetch upstream && 
 sudo git rebase upstream/master && sudo git pull origin master  
 echo "Config file"
 sudo unlink /etc/nginx/sites-enabled/default
 sudo unlink /etc/nginx/sites-enabled/pesbuk 
 sudo cp ~/bash-example/pesbuk /etc/nginx/sites-available/ 
 sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
 echo "Enable service"
 sudo nginx -t
 sudo systemctl restart nginx
 sudo systemctl enable nginx
 echo "Setup selesai"
#exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
