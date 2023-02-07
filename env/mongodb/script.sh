#!/bin/bash

echo -------------- Import the public key for APT ---------------
sudo wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

echo ---------------- Create list file for MongoDV --------------
sudo echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

echo ------------------------ Update packages -------------------
sudo apt-get update -y

echo ------------------------ Install Mongo ---------------------
sudo apt-get purge mongo*
sudo apt-get install mongodb-org -y

echo ------------------------ Enable MongoDB on Boot ------------
sudo systemctl enable mongod.service

echo ---------------------- Copy New Conf File ------------------
sudo cp /home/vagrant/env/mongodb/mongod.conf /etc/mongod.conf

echo ------------------------ Restart Mongo Service -------------
sudo systemctl restart mongod.service

echo ------------------------ Restart Mongo Service -------------
sudo systemctl enable mongod.service

echo ------------------------- Get Mongo Status -----------------
sudo systemctl status mongod