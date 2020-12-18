#!/bin/bash

jawaban="Y"

read  -p  "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install nginx unzip wget -y
 echo "Download web data"
 wget https://github.com/jokoss92/jokoss92.github.io/archive/master.zip
 echo "Ekstrak file"
 unzip master.zip
 echo "Memindahkan data"
 sudo rm /var/www/html/*
 sudo rm -R /var/www/html/*
 sudo mv jokoss92.github.io-master/* /var/www/html
 echo "Enable service"
 sudo systemctl enable nginx
 echo "Setup selesai"
 exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
