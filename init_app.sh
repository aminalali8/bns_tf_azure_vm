#!/bin/bash
sudo apt update
sudo apt install -y git
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
yes | sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
mkdir -p app
cd app
git clone https://github.com/aminalali8/demo-books.git ./
sudo docker-compose up -