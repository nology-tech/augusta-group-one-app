#!/bin/bash

echo ---------- Import GPG Key - MongoDB ----------
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

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

echo ---------- Install MongoDB ----------
sudo apt install mongodb-org -y

echo ---------- Start MongoDB ----------
sudo systemctl start mongod.service

echo ---------- Enable MongoDB on Boot ----------
sudo systemctl enable mongod.service

echo ---------- Update Conf ----------
sudo cp /home/vagrant/env/mongodb/mongod.conf /etc/mongod.conf

echo ---------- Restart Mongo Service ----------
sudo systemctl restart mongod.service

echo ---------- Show Status ----------
sudo systemctl status mongod.service

echo ---------- Install Dependencies ------------
cd /home/vagrant/api
npm install -g npm
npm install --no-bin-links

echo --------- Setting Environment Variables -------
export DB_URI="mongodb://127.0.0.1:27017/snake"
echo $DB_URI

echo ---------- Start API ------------
node server.js