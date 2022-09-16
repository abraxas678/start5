#!/bin/bash
bash <(curl -s https://raw.githubusercontent.com/abraxas678/start5/master/check_user.sh)
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --ssh
sudo tailscale ip
sudo tailscale status
