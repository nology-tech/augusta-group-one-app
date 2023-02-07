#!/bin/bash

echo -------------- Update source list --------------
sudo apt-get update -y

echo ------------- Installing Nginx ----------------
sudo apt install nginx -y

echo ------- Set up Server Block -----------
sudo mkdir -p /var/www/snake.game/html
sudo chown -R $USER:$USER /var/www/snake.game/html
sudo chmod -R 755 /var/www/snake.game
sudo nano /etc/nginx/sites-available/snake.game
sudo ln -s /etc/nginx/sites-available/snake.game /etc/nginx/sites-enabled/
sudo nginx -t

echo ---------- Copy Game ----------
sudo cp -r app/* /var/www/snake.game/html/

echo ---------- Save DB IP Address  ----------
DB_IP=http://$(sudo cat /home/vagrant/global/hostname.txt | xargs)/api/scores

echo ---------- Update the Snake Game server_name to this IP address --------------
sudo sed "s/IP_ADDRESS/$(hostname -I)/" /home/vagrant/env/snake/snake-proxy.conf > /etc/nginx/sites-available/snake.game
sudo sed -i "s/IP_ADDRESS/$(echo $DB_IP | sed 's#/#\\/#g')/" /var/www/snake.game/html/scripts/Game.js


echo ---------- Reload Nginx --------------
sudo systemctl reload nginx.service