#!/bin/bash
export PATH=$PATH:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/s>
echo "#####################################################################"
echo "                      CHECKING USER DETAILS"
echo "#####################################################################"
echo
echo "CURRENT USER: $USER"
read -t 1 me
MY_SUDO="sudo"
echo $MY_SUDO >/home/abraxas/mysudo
[[ $USER != "abraxas" ]] && [[ ! $(id -u abraxas) ]] && $MY_SUDO adduser abraxas && $MY_SUDO passwd abra>
[[ $USER != "abraxas" ]] && su abraxas
echo "CURRENT USER: $USER"
[[ $USER != "abraxas" ]] && echo BUTTON && read me || read -t 1 me

curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --ssh
sudo tailscale ip
sudo tailscale status
