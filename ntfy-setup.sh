#!/bin/bash
curl -sSL https://archive.heckel.io/apt/pubkey.txt | sudo apt-key add -
sudo apt install apt-transport-https
sudo sh -c "echo 'deb [arch=amd64] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"  
sudo apt update
sudo apt install ntfy
sudo mkdir /etc/ntfy
sudo cp ntfy-setup/* /etc/ntfy -r
sudo chown abraxas: -R /etc/ntfy

### certbot
sudo apt install snapd -y
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo
echo "your external IP:"
dig +short myip.opendns.com @resolver1.opendns.com  
echo
echo "subdomain weiterleiten"
sudo certbot certonly
echo
echo "cat /etc/ntfy/server.yml"
cat /etc/ntfy/server.yml
echo
sudo systemctl enable ntfy
sudo systemctl start ntfy
