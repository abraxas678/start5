#!/bin/bash
################################## FUNCTIONS ###########################################
countdown() {
  secs=$1
  shift
  msg=$@
  while [ $secs -gt 0 ]
  do
    printf "\r\033[K %.d $msg" $((secs--))
#    printf "\r\033[KWaiting %.d seconds $msg" $((secs--))
    sleep 1
  done
  echo
}

pp() {
  rich -u --print Pueue
  rich -a rounded --print "$( \
  rich -a rounded --print "$(pueue status | grep Success |awk '{ print $2,"  " $3,"  " $5," " $6 }' |sed 's/Success/\[green\]Success\[\/green\]/')"
  rich -a rounded --print "$(pueue status | grep Queue |awk '{ print $2,"  " $3,"  " $5," " $6 }' |sed 's/Queue/\[Yellow\]Queue\[\/Yellow\]/')"
  rich -a rounded --print "$(pueue status | grep Failure |awk '{ print $2,"  " $3,"  " $5," " $6 }' |sed 's/Failure/\[red\]Failure\[\/red\]/')" )"
}

pueue-init() {
  x=0
  while [[ $x -eq 0 ]]; do
  echo "PUEUE INIT"
  rm -f /home/abraxas/tmp/pueuestatus.txt
  countdown 1
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  /home/linuxbrew/.linuxbrew/bin/pueue status >> /home/abraxas/tmp/pueuestatus.txt 2>> /home/abraxas/tmp/pueuestatus.txt
  # /home/linuxbrew/.linuxbrew/bin/pueue status
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt) = *"Failed to initialize client"* ]] &&  /home/linuxbrew/.linuxbrew/bin/pueued -d && sleep 2 &&  /home/linuxbrew/.linuxbrew/bin/pueue status
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt) = *"Permission denied"* ]] && $MY_SUDO chown -R abraxas: /run/user && $MY_SUDO chmod +x /home/linuxbrew/.linuxbrew/bin/pueue &&  /home/linuxbrew/.linuxbrew/bin/pueued -d && sleep 2 &&  /home/linuxbrew/.linuxbrew/bin/pueue status
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt) = *"Please stop the daemon beforehand or delete the file manually"* ]] && x=1
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt | head -n5) = *"Group"* ]] && x=1 || $MY_SUDO chown -R abraxas: /run/user && $MY_SUDO chmod +x /home/linuxbrew/.linuxbrew/bin/pueue && $MY_SUDO chmod +x /home/linuxbrew/.linuxbrew/bin/pueued && /home/linuxbrew/.linuxbrew/bin/pueued -d && /home/linuxbrew/.linuxbrew/bin/pueued -d
  sleep 1
  done
  rm -f /home/abraxas/tmp/pueuestatus.txt
}

trenner() {
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue -u --print "$@"
}
