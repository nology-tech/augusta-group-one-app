#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo -------------- Update source list --------------
sudo apt-get update -y

echo -------------- Install Python ------------------
sudo apt-get install software-properties-common -y

echo -------------- Download node v16 ---------------
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

echo ------------------ Install node ----------------
sudo apt-get install -y nodejs -y

echo ------------------ Install npm -----------------
sudo apt-get install npm -y

echo ------------- Installing Apache ----------------
sudo apt install apache2 -y

echo ------------ Enabling Apache Proxy -------------
sudo a2enmod proxy
sudo a2enmod proxy_http

echo ------- Add nology Apache Proxy File -----------
cp /home/vagrant/env/jsapp/jsapp-proxy.conf /etc/apache2/sites-available
ls -la /etc/apache2/sites-available

echo ------ Remove Default Apache Conf file ---------
sudo a2dissite 000-default.conf

echo ------- Register jsapp Apache Proxy File ------
sudo a2ensite jsapp-proxy.conf

echo -------------- Restart Apache ------------------
sudo systemctl reload apache2

echo --------------- Move into App Folder -----------
cd ../vagrant/app/

echo -------------- Install Dependancies ------------
npm install

# echo -------------------- Run App -------------------
# node app.js
