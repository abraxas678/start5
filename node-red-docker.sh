#!/bin/bash
[[ $(docker version | wc -l) -gt 15 ]] && sudo apt install -y docker.io && sudo apt install -y docker-compose
mkdir $HOME/docker
mkdir $HOME/docker/node-red
cd $HOME/docker/node-red
wget https://raw.githubusercontent.com/abraxas678/start5/master/docker-compose-node-red.yml
mv docker-compose-node-red.yml docker-compose.yml
