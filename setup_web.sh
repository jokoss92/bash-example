#!/bin/bash

jawaban="Y"

read -p "Apakah kamu yakin untuk menginstall webserver ? (Y/n) " pilih; 
if  [ $pilih == $jawaban ];
then
 echo "Update repository"
 sudo apt-get update
 echo "Install webserver"
 sudo apt-get install nginx php-fpm unzip wget mysql-server php-mysql -y
 echo "Delete default html"
 sudo rm -rf /var/www/html/*
 #sudo rm  /var/www/html/*
 echo "Download web data"
 cd /var/www/html/ && sudo wget https://github.com/sdcilsy/sosial-media/archive/master.zip && sudo unzip master.zip && sudo mv sosial-media-master/* /var/www/html/
# echo "Memindahkan data"
# sudo mv sosial-media-master/* /var/www/html/
 echo "Config file"
 sudo unlink /etc/nginx/sites-enabled/default
 sudo unlink /etc/nginx/sites-enabled/pesbuk 
#sudo tee /etc/nginx/sites-available/pesbuk <<EOF
#server {
#        listen 80;
#        root /var/www/html;
        # Add index.php to the list if you are using PHP
#        index index.php index.html index.htm index.nginx-debian.html;
#        server_name 192.168.43.190;
        #bisa diganti dengan ip address localhostmu atau ip servermu, nanti kalau sudah ada domain diganti nama domainmu. 
#        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
#                try_files $uri $uri/ =404;
#        }
#        location ~ \.php$ {
#          include snippets/fastcgi-php.conf;
#          fastcgi_pass unix:/run/php/php7.2-fpm.sock;
#        }
#}
#EOF
 sudo cp /home/vagrant/bash-example/pesbuk /etc/nginx/sites-available/ 
 sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
# echo "Import database"
 #sudo mysql -uroot -e "CREATE DATABASE 'dbsosmed' DEFAULT CHARACTER SET utf8 */;"
 #sudo mysql -uroot -e "CREATE USER 'devopscilsy' IDENTIFIED BY '1234567890';"
 #sudo mysql -uroot -e "FLUSH PRIVILEGES;"
# sudo mysql -uroot  << EOF
#CREATE DATABASE dbsosmed;
#CREATE USER 'devopscilsy' IDENTIFIED BY '1234567890';
#GRANT ALL PRIVILEGES ON dbsosmed.* TO devopscilsy@'localhost' IDENTIFIED BY '1234567890';
#FLUSH PRIVILEGES;
#EOF
 #sudo mysql -uroot mysql < /var/www/html/dump.sql
 echo "Enable service"
 sudo nginx -t
 sudo systemctl restart nginx
 sudo systemctl enable nginx
 echo "Setup selesai"
# exit 0
else
 echo "Setup dibatalkan"
 exit 1
fi
