#!/bin/bash
sudo tput civis
### name always as last one
name=$(echo $@ | sed 's/.*name=//')
i=1; x=0
printf "choose:\t\n" >choose.csv
myv=$(eval "echo \${$i}")
while [[ $x = 0 ]]; do
printf " [$i] $myv\t\n" >>choose.csv
i=$((i+1))
myv=$(eval "echo \${$i}")
[[ $myv = "" || $myv = *"name="* ]] && x=1
done

[[ $@ = *"name="* ]] && $RICH --print "$($RICH choose.csv)" --panel square --title "$name" --panel-style blue || $RICH choose.csv
sudo tput sc; 
choose2.sh
#read -n 1 myc 
sudo tput rc; 
sudo tput cuu1; 
sudo tput ed; sudo tput cnorm
myc=$(cat myc)
sudo tput setaf 76
echo ">>> $myc"
sudo tput sgr0
rm -f myc
