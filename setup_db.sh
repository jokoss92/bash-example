#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall dbserver ? (Y/n) " pilih;
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install mysql-server -y
 echo "Setting db"
 sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS dbsosmed;
CREATE USER IF NOT EXISTS 'devopscilsy'@'%' IDENTIFIED BY '1234567890';
GRANT ALL PRIVILEGES ON * . * TO 'devopscilsy'@'%';
FLUSH PRIVILEGES;
EOF
 echo "Import db"
 mysql -udevopscilsy -p1234567890 dbsosmed < ~/bash-example/dump.sql
 echo "Restart db service"
 sudo systemctl enable mysql && sudo systemctl restart mysql && sudo systemctl status mysql 
 echo "Setup selesai"
#exit 0
else
 echo "Setup dibatalkan"
#exit 1
fi


