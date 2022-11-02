#!/bin/bash
echo "#####################################################################"
echo "                           INSTALL PUEUE"
echo "#####################################################################"
rclone copy df:bin/pueue-done.sh $HOME/bin 
rclone copy df:bin/age.sh $HOME/bin 
chmod +x /home/abraxas/bin/*.sh
echo;
  countdown 1
  brew install pueue
  echo; echo "INSTALL RICH-CLI"
  brew install rich
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --print "rich installed" -u
  countdown 1
  sudo chown -R abraxas: /run/user
  sudo chown -R abraxas: /home
  sudo chmod +x /home/abraxas/.cargo/bin/pueue >/dev/null 2>/dev/null
  sudo chmod +x /home/abraxas/.cargo/bin/pueued >/dev/null 2>/dev/null
  sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueue
  sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueued
  source $HOME/start5/path.dat
  echo; echo "pueued -d"
  /home/linuxbrew/.linuxbrew/bin/pueued -d && /home/linuxbrew/.linuxbrew/bin/pueue start

x=0
rm -f $HOME/tmp/pueuestatus.txt
pueue-init 2>/dev/null

rm -f $HOME/tmp/pueuestatus.txt
#/home/linuxbrew/.linuxbrew/bin/pueue status | tails -n 10
trenner Pueue initialized
countdown 1
