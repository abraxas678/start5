#!/bin/bash
echo "#####################################################################"
echo "                      CHECKING USER DETAILS"
echo "#####################################################################"
echo; sleep 1
echo "CURRENT USER: $USER"
read -t 1 me
MY_SUDO="sudo"
echo $MY_SUDO >/home/abraxas/mysudo
[[ $USER != "abraxas" ]] && [[ ! $(id -u abraxas) ]] && $MY_SUDO adduser abraxas && $MY_SUDO passwd abraxas && $MY_SUDO usermod -aG $MY_SUDO abraxas && su abraxas
[[ $USER != "abraxas" ]] && su abraxas
echo "CURRENT USER: $USER"
[[ $USER != "abraxas" ]] && echo BUTTON && read me || read -t 1 me

sudo ls >/dev/null 2>/dev/null
