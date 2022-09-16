#!/bin/bash
mkdir $HOME/docker
mkdir $HOME/docker/node-red
cd $HOME/docker/node-red
bash <(curl -s https://raw.githubusercontent.com/abraxas678/start5/master/node-red-docker.sh)
wget https://raw.githubusercontent.com/abraxas678/start5/master/docker-compose-node-red.yml
mv docker-compose-node-red.yml docker-compose.yml
