#!/bin/bash
#https://github.com/GitJournal/git-auto-sync
sudo echo "deb [trusted=yes] https://apt.fury.io/vhanda/ /" | sudo tee /etc/apt/sources.list.d/git-auto-sync.list
sudo apt-get update
sudo apt-get install -y git-auto-sync
