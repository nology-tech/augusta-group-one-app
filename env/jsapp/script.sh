#!/bin/bash

echo ---------- Update the System ----------
sudo apt-get update -y

echo -------------- Install Python ------------------
sudo apt-get install software-properties-common -y

echo -------------- Download node v16 ---------------
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

echo ------------------ Install node ----------------
sudo apt-get install nodejs -y

echo ------------------ Install npm -----------------
sudo apt-get install npm -y

echo ------------- Installing Apache ----------------
sudo apt install apache2 -y

echo ------------ Enabling Apache Proxy -------------
sudo a2enmod proxy
sudo a2enmod proxy_http

echo ------- Add Custom Apache Proxy File -----------
cp /home/vagrant/env/jsapp/jsapp-proxy.conf /etc/apache2/sites-available
ls -la /etc/apache2/sites-available

echo ------ Remove Default Apache Conf file ---------
sudo a2dissite 000-default.conf

echo ------- Register Custom Apache Proxy File ------
sudo a2ensite jsapp-proxy.conf

echo -------------- Restart Apache ------------------
sudo systemctl reload apache2

echo ------- Set up Server Block -----------
sudo mkdir -p /var/www/snake.game/html
sudo chown -R $USER:$USER /var/www/snake.game/html
sudo chmod -R 755 /var/www/snake.game
sudo ln -s /etc/apache2/sites-available/snake.game /etc/apache2/sites-enabled/


echo -------------- Restart Apache ------------------
sudo systemctl reload apache2

echo ---------- Copy Game ----------
sudo cp -r app/* /var/www/snake.game/html/

echo ---------- Save DB IP Address  ----------
export DB_IP="http://192.168.56.20:5550/api/scores"
echo $DB_IP

echo ---------- Update Game.js with DB IP Address  ----------
sudo sed -i "s/IP_ADDRESS/$(echo $DB_IP | sed 's#/#\\/#g')/" /var/www/snake.game/html/scripts/Game.js



