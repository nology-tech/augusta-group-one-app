#!/bin/bash
echo ---------- Import GPG Key - MongoDB ----------
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

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
npm install -g npm -y

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

echo ---------- Get Host IP ----------
sudo hostname -I > /home/vagrant/global/hostname.txt

echo --------- Setting Environment Variables -------
touch .bash_aliases
echo 'export DB_URI="mongodb://127.0.0.1:27017/snake"' > .bash_aliases
cat .bash_aliases

echo ---------- Install Dependencies ------------
cd /home/vagrant/api
pwd
sudo npm install -g npm
sudo npm install

echo ---------- Start API ------------
# node server.js