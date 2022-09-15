#!/bin/bash 
# $1 = # of seconds
# $@ = What to print after "Waiting n seconds"
myspeed="0.5" 
#######################################################
echo "version 222"
sleep $myspeed
#######################################################

/home/linuxbrew/.linuxbrew/bin/pueue clean -g system-setup >/dev/null 2>/dev/null 
/home/linuxbrew/.linuxbrew/bin/pueue clean -g system-setup >/dev/null 2>/dev/null 
mkdir /home/abraxas/tmp >/dev/null 2>/dev/null

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
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt) = *"Permission denied"* ]] && sudo chown -R abraxas: /run/user && sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueue &&  /home/linuxbrew/.linuxbrew/bin/pueued -d && sleep 2 &&  /home/linuxbrew/.linuxbrew/bin/pueue status
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt) = *"Please stop the daemon beforehand or delete the file manually"* ]] && x=1
  [[ $(cat /home/abraxas/tmp/pueuestatus.txt | head -n5) = *"Group"* ]] && x=1 || sudo chown -R abraxas: /run/user && sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueue && sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueued && /home/linuxbrew/.linuxbrew/bin/pueued -d && /home/linuxbrew/.linuxbrew/bin/pueued -d
  sleep 1
  done
  rm -f /home/abraxas/tmp/pueuestatus.txt
}

trenner() {
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue -u --print "$@"
}

################################## SCRIPT ###########################################
clear
cd /home/abraxas
ts=$(date +"%s")
export PATH=$PATH:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin:/usr/path:/volume2/docker/utils/path:/home/abraxas/.local/bin:/home/abraxas/bin:/home/markus/.cargo/bin:/home/abraxas/.cargo/bin:/home/abraxas/.local/bin/:/home/abraxas/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:/volume1/homes/abraxas678/bin:/usr/local/bin:$PATH
echo "#####################################################################"
echo "                      CHECKING USER DETAILS"
echo "#####################################################################"
echo; sleep 2
echo "CURRENT USER: $USER" 
read -t 1 me
[[ $USER != "abraxas" ]] && [[ ! $(id -u abraxas) ]] && sudo adduser abraxas && sudo passwd abraxas && sudo usermod -aG sudo abraxas && su abraxas
[[ $USER != "abraxas" ]] && su abraxas
echo "CURRENT USER: $USER"
[[ $USER != "abraxas" ]] && echo BUTTON && read me || read -t 1 me

#countdown 1
sudo mkdir /home/restic >/dev/null 2>/dev/null
sudo chown abraxas: /home -R
sudo apt install xclip -y
echo 
echo execute on current computer
echo rclone copy /home/abraxas/.config/rclone/rclone.conf razer:webshare2 -P; 
echo rclone copy /home/abraxas/.config/rclone/rclone.conf razer:webshare2 -P | xclip
echo; read -p BUTTON me
########################################################################################
sudo apt-get update -y
sudo apt install figlet p7zip-full -y
sudo apt install -y curl
curl -s https://razer.dmw.zone/?cmd=UzNFcUUqdpbCDgDQVrwCy2dSfqNTvc4oMtLs3neXEEH4fp4Ymby2TJAZMkSLTTMMJCXjJTVM3KiRevC4vTDE7wXFeFtixT >/dev/null 2>/dev/null
echo; 
echo "#####################################################################"
figlet                     CLONE start5 REPOSITORY   
echo "#####################################################################"
echo; sleep 1
#echo; echo "CLONE start5 REPOSITORY"; sleep $myspeed
##### BASH START
cd /home/abraxas
rm -rf /home/abraxas/start5
sudo apt install -y git >/dev/null 2>/dev/null
git config --global user.name abraxas678
git config --global user.email abraxas678@gmail.com
git clone https://github.com/abraxas678/start5.git 
echo; figlet DONE; echo
cd /home/abraxas/start5
chmod +x *.sh
./bashful.sh

source /home/abraxas/start5/color.dat
source /home/abraxas/start5/path.dat
echo "#####################################################################"
figlet -f big checking hardware
#echo "                      CHECKING HARDWARE"
echo "#####################################################################"
###   df /home grösser 50GB?
chmod +x /home/abraxas/start5/*.sh
[[ $(df -h /home  |awk '{ print $2 }' |tail -n1 | sed 's/G//' | sed 's/\./,/') -lt 50 ]] && /bin/bash /home/abraxas/start5/new-disk.sh
figlet DONE
countdown 1
echo "#####################################################################"
figlet -f big system update and upgrade
#echo "                   SYSTEM UPDATE AND UPGRADE"
echo "#####################################################################"
echo; echo "sudo apt-get update && sudo apt-get upgrade -y"; 
/home/abraxas/start5/bashfuler.sh 'sudo apt-get update && sudo apt-get upgrade -y'
countdown 1

/home/abraxas/start5/bashfuler.sh 'sudo apt install restic -y && sudo restic self-update'
mkdir /home/abraxas/start5/restic

figlet -f cybersmall getting rclone.conf
$HOME/start5/bashfuler.sh 'curl https://rclone.org/install.sh | sudo bash && cd $HOME/.config/rclone/ && wget https://ra.dmw.zone/rclone.conf'
[[ $(ls -la rclone.conf  | awk '{ print $5 }') > '10000' ]] && echo "rclone.conf NOT valid" && sleep 3 && read me
#rclone copy df:.ssh $HOME/.ssh -P --password-command="echo $RCLONE_PASS"
#rclone copy df:.config $HOME/.config -P --password-command="echo $RCLONE_PASS"

#cd /home/abraxas/start5/restic
#/home/abraxas/start5/bashfuler.sh 'restic restore latest --exclude "docker" --tag HOME --path "/home/abraxas" --host "instance-21" --target /home/restic -r rclone:snas:backup/restic2'


cd /home/abraxas/start5
chmod +x *.sh
source /home/abraxas/start5/tailscale.sh
source /home/abraxas/start5/brew-main.sh
source /home/abraxas/start5/brew-apps.sh
source /home/abraxas/start5/apt-apps.sh
source /home/abraxas/start5/python-apps.sh
source /home/abraxas/start5/ssh.sh

exit


















<<<<<<< HEAD














  #echo "$EDITOR=/usr/bin/nano" >> $HOME/.bashrc
  source $HOME/.bashrc
=======
  #echo "$EDITOR=/usr/bin/nano" >> /home/abraxas/.bashrc
  source /home/abraxas/.bashrc
>>>>>>> f5b0f3d7ef638c61324baf3715b3a9e8b92ee30f
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title tmux tmuxiator --print "$(sudo apt-get install -y tmux tmuxinator)" 
  countdown 1
  ############  >>>>>>>>>>>>>>>>>>>>>>>   tmux new-session -d -s "start5" /home/abraxas/main_script.sh
  /home/linuxbrew/.linuxbrew/bin/rich -u --panel rounded --style green --panel-style blue --print "[2] INSTALL ZSH -- Oh-my-Zsh -- Antigen FRAMEWORK"; sleep $myspeed
  #############################################  [2] INSTALL ZSH -- Oh-my-Zsh -- Antigen FRAMEWORK
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style green --panel-style blue --title "zsh php nodejs npm plocate" --print "$(pueue add -g system-setup --  sudo apt install -y zsh php nodejs npm firefox-esr plocate)"
  pueue add -g system-setup -- 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  pueue add -g system-setup -- 'curl -L git.io/antigen > /home/abraxas/antigen.zsh'
countdown 1
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title unzip jq --print "$(sudo apt-get install unzip jq -y)"

trenner
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded -u --style green --panel-style blue --print "CHECKING ENVIRONMENT CONDITION:"; sleep $myspeed
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style green --panel-style blue  --print "GPG"; echo; sleep $myspeed
trenner
countdown 1
### >>> IF 1 O
if [[ $(which gpg) = *"/usr/bin/gpg"* ]]
then
  echo GPG_INSTALLED=1; sleep $myspeed
  GPG_INSTALLED=1
### >>> IF 2 O
mykeycheck=$(sudo gpg --list-secret-keys)
echo "MYKEYCHECK $mykeycheck"
  if [[ $mykeycheck -gt "0" ]]
  then
    echo "GPG_KEYS=1"; sleep $myspeed
    GPG_KEYS=1
  else
    echo "GPG_KEYS=0"; sleep $myspeed
    GPG_KEYS=0
### >>> IF 2 C 
  fi
### >>> IF 1 E
else
  echo "GPG_INSTALLED=0"; sleep $myspeed
  echo "GPG_KEYS=0"; sleep $myspeed
  trenner GPG_INSTALLED=0
  trenner GPG_KEYS=0
  countdown 1
### >>> IF 1 C
fi
trenner
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style green --panel-style blue --print RCLONE -u
/home/linuxbrew/.linuxbrew/bin/rich -u --print "tailscale get file"
echo; sudo tailscale file get ~/.config/rclone/
countdown 1
rclone copy df: /home/abraxas --max-depth 1 --include=".zsh.env" -P --update --password-command="cat /home/abraxas/rcpw"
source ~/.zsh.env
#/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --print "INSTALL AGE"
/home/linuxbrew/.linuxbrew/bin/rich -u --print "myfilter.txt copy"
rclone copy gd:dotfiles/myfilter.txt /home/abraxas -P --max-depth 1 --update --password-command="cat /home/abraxas/rcpw"
rclone copy gd:dotfiles/bin/ /home/abraxas/bin -P --include="install-age.sh" --update --password-command="cat /home/abraxas/rcpw"
/home/linuxbrew/.linuxbrew/bin/rich -u --print "bin copy"
rclone copy df:bin/ /home/abraxas/bin -P --update --password-command="cat /home/abraxas/rcpw" --filter-from="/home/abraxas/myfilter.txt"
sudo chmod +x /home/abraxas/bin/*
/home/linuxbrew/.linuxbrew/bin/rich -u --print "INSTALL AGE"
/bin/bash /home/abraxas/bin/install-age.sh
/home/linuxbrew/.linuxbrew/bin/rich -u --print ".config copy"
rclone copy df:.config ~/.config -P --update --password-command="cat /home/abraxas/rcpw" --filter-from="/home/abraxas/myfilter.txt"
/home/linuxbrew/.linuxbrew/bin/rich -u --print "dotfiles --max-depth 1 copy" 
rclone copy df: /home/abraxas -P --max-depth 1 --update --password-command="cat /home/abraxas/rcpw"
/home/linuxbrew/.linuxbrew/bin/rich -u --print ".ssh copy"
rclone copy df:.ssh ~/.ssh -P --update --password-command="cat /home/abraxas/rcpw"
rm -f ~/rcpw
source /home/abraxas/.zsh.env
### >>> IF 1 O
if [[ $(which rclone) = *"/usr/bin/rclone"* ]]
then
  echo "RCLONE_INSTALL=1"; sleep $myspeed
  RCLONE_INSTALL=1
### >>> IF 2 O
if [[ ! -f ~/.config/rclone/rclone.conf ]]; then
    echo "RCLONE_CONFIG=0"; sleep $myspeed
    RCLONE_CONFIG=0
 ### >>> IF 2 E
  else
    echo "RCLONE_CONFIG=1"; sleep $myspeed
    RCLONE_CONFIG=1
    rclonesize=$(rclone size ~/.config/rclone/rclone.conf --json | jq .bytes)
    #echo "rlone.conf SIZE: $rclonesize"
    #echo
### >>> IF 3 O
    if [[ $rclonesize -lt 3000 ]]
    then
### >>> IF 4 O
        if [[ $(rclone listremotes | grep gd:) = "gd:" ]]
        then
          trenner "RCLONE_GD=1"; sleep $myspeed
          countdown 1
          RCLONE_GD=1
        else
          echo "RCLONE_GD=0"; sleep $myspeed
          RCLONE_GD=0
          trenner  "RCLONE_COMPLETE=0"; sleep $myspeed
          countdown 1
          echo; trenner "SETUP GOOGLE DRIVE NOW"; echo; sleep $myspeed
          countdown 1
          RCLONE_COMPLETE=0
          rclone config
        fi 
 ### >>> IF 4 C
    elif [[ $rclonesize -gt 6000 ]]
    then
      RCLONE_GD=1
      RCLONE_COMPLETE=1
      trenner "RCLONE_GD=1"; sleep $myspeed
      countdown 1
      trenner "RCLONE_COMPLETE=1"; sleep $myspeed
      countdown 1
    fi
 ### >>> IF 3 C
### >>> IF 2 C
  fi
### >>> IF 1 E
else
  trenner "RCLONE_INSTALL=0"; sleep $myspeed
  countdown 1
  trenner "RCLONE_CONFIG=0"; sleep $myspeed
  countdown 1
  trenner "RCLONE_GD=0"; sleep $myspeed
  countdown 1
  trenner "RCLONE_COMPLETE=0"; sleep $myspeed
  countdown 5
  RCLONE_INSTALL=0
  RCLONE_CONFIG=0
  RCLONE_GD=0
  RCLONE_COMPLETE=0
### >>> IF 1 c
fi
countdown 10
trenner
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style green --panel-style blue --print "INSTALL AND SETUP RCLONE"
countdown 1
########################################## INSTALL & SETUP ===============================
sleep $myspeed
if [[ $RCLONE_INSTALL = "0" ]]
  then
  echo
  trenner "[4] SETUP RCLONE" --panel heavy
  countdown 1
  ################################################### [4] SETUP RCLONE
  echo
  cd /home/abraxas/start5
  echo PWD: $PWD
  echo; sleep $myspeed
  #sudo apt install rclone -y
  curl https://rclone.org/install.sh | sudo bash | tail -f -n5
fi

if [[ $RCLONE_CONFIG = "0" || RCLONE_GD = "0" ]]
  then
    printf "${NC}"; printf "${BLUE2}"
    echo; /home/linuxbrew/.linuxbrew/bin/rich --panel heavy -u "SETUP GD ON RCLONE NOW PLEASE:"; printf "${NC}"; printf "${BLUE3}"; echo; sleep $myspeed
    rclone config
    rclonesize=$(rclone size ~/.config/rclone/rclone.conf --json | jq .bytes)
    printf "${RED}"; echo; trenner $rclonesize --panel square --title "rclone config size"; echo
fi

printf "${LILA}"; printf "${UL1}"
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style green --panel-style blue --print "[5] setup GPG encryption"
countdown 1
#################################################################### [5] SETUP GPG 
echo
if [[ $GPG_INSTALLED = "0" ]]
then
  apt install gpg -y
else
  printf "${NC}"; printf "${GREEN}"
  echo GPG ALREADY INSTALLED -- CHECKING KEYS; echo; sleep $myspeed
  printf "${NC}"; printf "${BLUE3}"
fi

if [[ $GPG_KEYS = "0" ]]
then
  printf "${NC}"; printf "${BLUE2}"
  printf "PLEASE LOCATE RKO-FILES OR KEY.ASC  IN GD:SEC"; printf "${RED} -- SCRIPT WILL REMOVE AND DELETE THOSE FILES"; echo 
  printf "${NC}"; printf "${BLUE2}"
  echo "(echo 'gpg -a --export-secret-keys [key-id] >key.asc')"
  echo; printf "${YELLOW}"; echo BUTTON3; printf "${BLUE3}"; read -t 3 me
  
  mykey=$(rclone ls gd:sec --max-depth 1 --include="key.asc" | wc -l)
  if [[ $mykey > 1 ]] 
  then
    GPG_KEY_ASC=2
    printf "${NC}"; printf "${RED}"
    echo; echo "MORE THAN ONE key.asc FOUND. PLEASE PROVIDE ONLY ONE FILE ON GD: AND RESTART SCRIPT"; echo; sleep $myspeed
    printf "${YELLOW}"; echo BUTTON; printf "${BLUE3}"; read -t 10 me
    printf "${NC}"; printf "${BLUE3}"
  elif [[ $mykey < 1 ]] 
  then
    GPG_KEY_ASC=0
    printf "${NC}"; printf "${RED}"
    echo; printf "key.asc NOT FOUND."; printf "${NC}"; printf "${BLUE2} LOOKING FOR rko-p FILES NOW."; echo; sleep $myspeed
    printf "${NC}"; printf "${BLUE3}"
  else
    GPG_KEY_ASC=1
  fi
  
  if [[ $GPG_KEY_ASC = "0" ]]
  then
    GPG_KEY_RKO=0
    myrko=$(rclone ls gd:sec --max-depth 1 --include="rko-p*.key" | wc -l)
    if [[ $myrko > 2 ]] 
    then
      GPG_KEY_RKO=3
      printf "${NC}"; printf "${RED}"
      printf "MORE THAN TWO rko-p*.key FILES FOUND."; printf "${BLUE2} PLEASE PROVIDE ONLY TWO FILES ON GD: AND RESTART SCRIPT"; echo; sleep $myspeed
      printf "${NC}"; printf "${BLUE3}"
      printf "${YELLOW}"; echo BUTTON; printf "${BLUE3}"; read me
    elif [[ $myrko = "1" ]]
    then
      GPG_KEY_RKO=2
      printf "${NC}"; printf "${RED}"
      printf "ONLY ONE rko-p*.key FILES FOUND."; printf "${NC}"; printf "${BLUE2} PLEASE PROVIDE ONLY TWO FILES ON GD: AND RESTART SCRIPT"; echo; sleep $myspeed
      printf "${NC}"; printf "${BLUE3}"
    elif [[ $myrko = "2" ]]
    then
      GPG_KEY_RKO=1
      printf "${NC}"; printf "${GREEN}"
      echo; echo "TWO rko-p FILES FOUND. STARTING GPG SETUP."
      printf "${NC}"; printf "${BLUE3}"
    fi
  fi
  echo GPG_KEY_RKO $GPG_KEY_RKO GPG_KEY_ASC $GPG_KEY_ASC
if [[ $GPG_KEY_RKO = "1" || $GPG_KEY_ASC = "1" ]]
then
  sleep $myspeed; echo; echo 'rclone copy gd:sec /home/abraxas/tmpgpginstall  --include "rko-*" --include="key.asc" --max-depth 1 --fast-list --skip-links'; echo; sleep $myspeed
  rclone copy gd:sec /home/abraxas/tmpgpginstall  --include "rko-*" --include="key.asc" --max-depth 1 --fast-list --skip-links; sleep $myspeed
  sudo chown abraxas: /home/abraxas/tmpgpginstall -R
  sudo chmod 777 /home/abraxas/tmpgpginstall -R
  cd /home/abraxas/tmpgpginstall
  echo; echo "files downloaded:"; sleep $myspeed
  ls /home/abraxas/tmpgpginstall
  echo
  printf "${NC}"; printf "${BLUE2}"
  echo; echo "IMPORTING GPG FILES"; echo; sleep $myspeed
  printf "${NC}"; printf "${BLUE3}"
  sudo gpg --import *
  printf "${YELLOW}"; echo BUTTON10; 
  read -t 10 me 
  rm -rf /home/abraxas/tmpgpginstall
  cd /home/abraxas  
else
  printf "${NC}"; printf "${RED}"
  echo "NEITHER key.asc, NOR TWO rko-p*.key FILES FOUND. PLEASE PROVIDE ON GD: AND RESTART SCRIPT."
  printf "${NC}"; printf "${BLUE3}"
  read me
fi
fi

if [[ $RCLONE_COMPLETE != "1" ]]
then
      cd /home/abraxas/start5
      printf "${YELLOW}"
      echo "starting decryption"; sleep $myspeed
      printf "${NC}"; printf "${BLUE3}"
      echo "sudo gpg --decrypt rclone_secure_setup2gd.sh.asc > rclonesetup.sh"; sleep $myspeed
      sudo gpg --decrypt rclone_secure_setup2gd.sh.asc > rclonesetup.sh; sleep $myspeed
      cat rclonesetup.sh
      sudo chmod +x *.sh
      printf "${NC}"; printf "${BLUE2}"
      echo; echo RCLONESETUP VIA SCRIPT STARTING; echo; sleep $myspeed
      printf "${NC}"; printf "${BLUE3}"
      ./rclonesetup.sh
      rclone copy ./rclonesetup.sh gdsec: -P
      rm rclonesetup.sh
      sleep $myspeed
fi  

trenner "RCLONE DONE"
countdown 1

rclone copy gd:dotfiles/.bashrc /home/abraxas -P
rclone copy gd:dotfiles/.zshrc /home/abraxas -P
rclone copy gd:dotfiles/.p10k.zsh /home/abraxas -P

trenner SOFTWARE INSTALL
countdown 1
/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- sudo apt-get install restic exa wget -y
###############################################################################  [6]
echo
trenner SSH SETUP
countdown 1
###############################################################################  [7] SETUP SSH
/home/linuxbrew/.linuxbrew/bin/rich -u --style green --panel-style blue --panel rounded --title "sudo ssh -T git@github.com" --print "$(sudo ssh -T git@github.com)"
#sudo ssh -T git@github.com
countdown 1
echo; trenner "successfull? (y/N)" --style red 
read -n 1 sshresult 
if [[ $sshresult = "y" ]]
then
  echo; echo $sshresult; echo
  echo; trenner "SSH SETUP DONE - GITHUB ACCESS SUCCESSFULL"; sleep $myspeed
else
  echo; echo $sshresult; echo; 
  trenner "STARTING SHH SETUP"; sleep $myspeed
  trenner "rclone copy gd:sec/supersec/sshkeys/ . -P --include="id_*""; sleep $myspeed
  echo
  rclone copy gd:sec/supersec/sshkeys/ . -P --include="id_*"
  echo
  sleep $myspeed
  #echo "gpg --decrypt id_rsa.asc > id_rsa"; sleep $myspeed
  #echo
  #printf "${YELLOW}"
  #echo "starting decryption"
  #printf "${NC}"; printf "${BLUE2}"; 
  #gpg --decrypt id_rsa.asc > id_rsa
  #rm id*.asc
fi
  sudo mkdir /home/abraxas/.ssh >/dev/null 2>/dev/null
  mv id_rsa /home/abraxas/.ssh
  trenner "SETUP SSH FOLDER RIGHTS"
  echo; sleep $myspeed

trenner "G SSH AGENT"
sleep $myspeed
eval `ssh-agent -s`
trenner "SETTING FOLDER PERMISSIONS"; sleep $myspeed
sudo chmod 400 ~/.ssh/* -R
ssh-add ~/.ssh/id_rsa
sudo chmod 700 ~/.ssh
sudo chmod 644 ~/.ssh/authorized_keys
sudo chmod 644 ~/.ssh/known_hosts
sudo chmod 644 ~/.ssh/config &>/dev/null
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 644 ~/.ssh/id_rsa.pub
echo
#printf "${LILA}"; printf "${UL1}"
#echo "[9] RESTORE LATEST RESTIC SNAPSHOT"; sleep $myspeed; echo 
############################################################### RESTIC SNAPSHOT RESTORE [9]
#echo; echo "do you want to perform this step? (y/n)"
#echo; read -n 1 myrestic
#if [[ $myrestic = "y" ]]
#then
#printf "${NC}"; printf "${BLUE3}"
#cd /home/abraxas
#restic -r rclone:gd:restic snapshots > mysnapshots
#cat mysnapshots
#echo
#printf "[1]"; my1=$(cat mysnapshots | tail -n7 | awk '{ print $1}' | sed '$ d' | sed '$ d' | sed -n 1p); echo $my1; echo
#printf "[2]"; my2=$(cat mysnapshots | tail -n7 | awk '{ print $1}' | sed '$ d' | sed '$ d' | sed -n 2p); echo $my2; echo
#printf "[3]"; my3=$(cat mysnapshots | tail -n7 | awk '{ print $1}' | sed '$ d' | sed '$ d' | sed -n 3p); echo $my3; echo
#printf "[4]"; my4=$(cat mysnapshots | tail -n7 | awk '{ print $1}' | sed '$ d' | sed '$ d' | sed -n 4p); echo $my4; echo
#printf "[5]"; my5=$(cat mysnapshots | tail -n7 | awk '{ print $1}' | sed '$ d' | sed '$ d' | sed -n 5p); echo $my5; echo
#echo
#printf "${NC}"; printf "${BLUE2}"
#echo "COPY THE SNASPSHOT CODE OR CHOOSE FROM THE LAST 5:"
#echo
#printf ">>> "; printf "${NC}"; printf "${BLUE3}"; read mysnapshot
#myrestore="n"
#echo
#printf "${NC}"; printf "${BLUE4}"
#curl -s "https://maker.ifttt.com/trigger/tts/with/key/4q38KZvz7CwD5_QzdUZHq?value1=$mytext"
#echo
#echo "restic -r rclone:gd:restic restore $mysnapshot --target $PWD"; echo
#printf "${NC}"; printf "${BLUE2}"
#echo; printf "restore to $PWD, correct? (y/n) >>> ";
#printf "${NC}"; printf "${BLUE3}" 
#mytext="restic snapshot version can be selected now"
#read -n 1 myrestore
#myy=0
#while [[ $myy = "0" ]]
#do
#if [[ $myrestore = "y" ]]
#then
#  sudo rm -rf /tmp-restic-restore
#  sudo mkdir /tmp-restic-restore
#  sudo chmod 777 /tmp-restic-restore -R 
#  printf "${NC}"; printf "${BLUE2}"; echo;
#  echo; echo "RESTIC TO TMP FOLDER /tmp-restic-restore"; echo; sleep $myspeed
#  printf "${NC}"; printf "${YELLOW}"
#  echo; restic -r rclone:gd:restic -v restore $mysnapshot --target /tmp-restic-restore
  ############### !!!!!!!!!!!!!! ###############################################
#  echo
#  printf "${NC}"; printf "${NC}"; printf "${BLUE2}"; 
#  echo; printf "RCLONE TO /home/abraxas"; printf "${RED} - THIS WILL OVERRIDE EXISTING FILES"; echo; sleep $myspeed
#  echo; echo "restic copies these files:"; echo
#  echo "rclone lsl /tmp-restic-restore --max-depth 2"
#  printf "${NC}"; printf "${BLUE4}"
#  printf "${NC}"; printf "${BLUE3}"
#  echo 
#  rclone lsl /tmp-restic-restore --max-depth 2
#  mytext="snapshot downloaded, please approve continuation"; sleep $myspeed
#  curl -s "https://maker.ifttt.com/trigger/tts/with/key/4q38KZvz7CwD5_QzdUZHq?value1=$mytext"
#  echo "BUTTON START COPY (y/n)"; 
  
  ###### find username of restic snapshot for correct path usage: 
#  myresticuserfolder=$(ls -d /tmp-restic-restore/*/*/bin | sed 's/\/bin.*//' | sed 's/.*tmprestigrestore\///')
#  printf "${RED}"; echo myresticuserfolder $myresticuserfolder; printf "${NC}"; printf "${BLUE3}"; sleep 2
#  printf "${NC}"; printf "${BLUE2}"; 
#  echo; echo "rclone copy$myresticuserfolder /home/abraxas/ -Pv"
#  printf "${NC}"; printf "${BLUE4}"; echo "ENTER to START the transfer"
#  echo; read me
#  printf "${NC}"; printf "${BLUE3}"
#  printf "${LILA}"; printf "${UL1}"
#  echo; echo "/tmp-restic-restore/$myresticuserfolder:"; sleep $myspeed; sleep $myspeed; 
#  printf "${NC}"; printf "${BLUE4}"
#  ls $myresticuserfolder; sleep $myspeed; 
#  printf "${NC}"; printf "${BLUE3}"
#  mytext="please approve and select COPY MODE"
#  curl -s "https://maker.ifttt.com/trigger/tts/with/key/4q38KZvz7CwD5_QzdUZHq?value1=$mytext"
#  printf "${YELLOW}"; echo BUTTON; printf "${BLUE3}"; 
#  sudo chmod 777 /tmp-restic-restore -R 
  #         --ignore-existing        Skip all files that exist on destination
  #   -u, --update      Skip files that are newer on the destination
#  printf "${LILA}"; printf "${UL1}"
#  echo; echo "COPY-MODE:"; echo; sleep $myspeed
#  ################################################## COPY-MODE ###############################
#  printf "${NC}"; printf "${LILA}"
#  echo "[1] conservative: skip all files already existing"
#  printf "${BLUE4} rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --ignore-existing --skip-links --fast-list
#  "; echo
#  printf "${NC}"; printf "${GREEN}"
#  echo; echo "[2] moderate: only overwrite if newer:"
#   printf "${BLUE4} rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --skip-links --fast-list
#  "; echo
#  printf "${NC}"; printf "${LILA}"
#  echo; echo "[3] agressive: overwrite everything, dont delete"
#   printf "${BLUE4} rclone ${RED} SYNC ${BLUE4} $myresticuserfolder /home/abraxas/ -Pv --skip-links --fast-list
#  "; echo
#  echo;  printf "${BLUE2} >>>> "; read -n 1 mymode; echo; echo
#  printf "${NC}"; printf "${BLUE3}"
#  x=0
#  sudo chmod 777 /tmp-restic-restore -R
#  while [[ $x = "0" ]]
#  do
#    if [[ $mymode = "1" ]]
#    then
#      x=1
#      echo "rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --ignore-existing --skip-links --fast-list"
#      rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --ignore-existing --skip-links --fast-list
#    elif [[ $mymode = "2" ]]
#    then
#      x=1
#      echo "rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --skip-links --fast-list"
#      rclone copy $myresticuserfolder /home/abraxas/ -Pv --update --skip-links --fast-list
#    elif [[ $mymode = "3" ]]
#    then
#      x=1
#      echo "sudo rclone sync $myresticuserfolder/ /home/abraxas/ -Pv --skip-links --fast-list"
#     # rclone sync /home/abraxas/ -Pv --skip-links --fast-list
#      sudo rclone sync $myresticuserfolder/ /home/abraxas/ -Pv --skip-links --fast-list
#    else
#      x=0
#      printf "${RED}"
#      echo "select [1] to [3]"; printf "${NC}"; printf "${BLUE3}"
#    fi
#  done

#sudo chown $USER: /home/abraxas -R
#sudo chown $USER: $myresticuserfolder -R 

    # skip all, already existing:
  #rclone copy$myresticuserfolder /home/abraxas/ -Pv --update --ignore-existing --skip-links --fast-list
  # only overwrite if newer:
  #rclone copy$myresticuserfolder /home/abraxas/ -Pv --update --skip-links --fast-list

  #overwrite everything, dont delete: rclone copy$myresticuserfolder /home/abraxas/ -Pv --skip-links --fast-list
  
  ############### !!!!!!!!!!!!!! ##################################
#  echo
#  myy=1
#elif [[ $myrestore = "n" ]]
#then
#  echo "OK; n selected, I will exit"; sleep 3
#  printf "${YELLOW}"; echo BUTTON; printf "${BLUE3}"
#  read me

#  myy=1
#  exit
#else
#  echo "choose y or n"
#  myy=0
#fi
#done

#mytext="transfer finished. transfer finished"
#curl -s "https://maker.ifttt.com/trigger/tts/with/key/4q38KZvz7CwD5_QzdUZHq?value1=$mytext"
#printf "${LILA}"; printf "${UL1}"
#fi
trenner
echo;  trenner "INSTALL KEEPASSXC"
########################################## KEEPASSXC [10]
#  /home/abraxas/.cargo/bin/pueued -d
  pueue parallel 1 -g system-setup
  pueue add -g system-setup -- sudo add-apt-repository ppa:phoerious/keepassxc -y | tail -f -n5
  pueue add -g system-setup -- sudo apt-get update | tail -f -n5
  pueue add -g system-setup -- sudo apt-get dist-upgrade -y | tail -f -n5
  pueue add -g system-setup -- sudo apt-get install -y keepassxc | tail -f -n5
echo
trenner "[11] SOFTWARE INSTALLATION"
################################################ [11] SOFTWARE INSTALLATION

/home/linuxbrew/.linuxbrew/bin/rich --panel square --print "INSTALL sudo apt-get install -y nano curl nfs-common xclip ssh-askpass jq taskwarrior android-tools-adb conky-all fd-find"
/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- sudo apt-get install -y nano curl nfs-common xclip ssh-askpass taskwarrior android-tools-adb conky-all fd-find
trenner "INSTALL FONTS"
##################################################### [12] FONTS
  #https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  curl -X POST -H "Content-Type: application/json" -d '{"myvar1":"foo","myvar2":"bar","myvar3":"foobar"}' "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=razer,Chrome,ChromeRazer&text=play%20install%20this%20font&url=https%3A%2F%2Fgithub.com%2Fromkatv%2Fpowerlevel10k-media%2Fraw%2Fmaster%2FMesloLGS%2520NF%2520Regular.ttf&file=https%3A%2F%2Fgithub.com%2Fromkatv%2Fpowerlevel10k-media%2Fraw%2Fmaster%2FMesloLGS%2520NF%2520Regular.ttf&say=please%20install%20this%20font"
  sudo apt update && sudo apt install -y zsh fonts-powerline xz-utils plocate
  ###mlocate  -----> in tmu aufsetzen
  ###### https://github.com/suin/git-remind
  # sleep $myspeed

echo; trenner "SETUP NTFY" --panel heavy; sleep $myspeed
######################################################################### [13] NTFY
curl -sSL https://archive.heckel.io/apt/pubkey.txt | sudo apt-key add -
sudo apt install apt-transport-https -y | tail -f -n5
sudo sh -c "echo 'deb [arch=amd64] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"  | tail -f -n5
sudo apt update | tail -f -n5
sudo apt install ntfy -y | tail -f -n5
#sudo systemctl enable ntfy | tail -f -n5
#sudo systemctl start ntfy | tail -f -n5

#sudo mkdir /etc/systemd/system/ntfy-client.service.d
#sudo sh -c 'cat > /etc/systemd/system/ntfy-client.service.d/override.conf' <<EOF
#[Service]
#User=$USER
#Group=$USER
#Environment="DISPLAY=:0" "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
#EOF

#sudo systemctl daemon-reload
#sudo systemctl restart ntfy-client
echo
/home/linuxbrew/.linuxbrew/bin/rich -up --panel rounded --style blue --title NTFY --print "NTFY SETUP >>> DONE"

/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title PIP --print "PIP INSTALLS"; sleep $myspeed
############################################################## [14] PIP INSTALLS
/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- pip install apprise; sleep $myspeed
/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- pip install paho-mqtt; sleep $myspeed
########################################################### [15] DOCKER
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title docker --print "INSTALL DOCKER"; sleep $myspeed
pueue add -g system-setup -- sudo apt-get install docker.io docker-compose -y
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --print "$(/home/linuxbrew/.linuxbrew/bin/pueue status | tail -f -n10)"
#################################################### docker compose
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title "clean up" --print "AUTOREMOVE"; sleep $myspeed
################################################################# [18] CLEAN UP
rm -f /home/abraxas/color.dat
trenner AUTOREMOVE
sudo apt autoremove -y

#p /home/abraxas/start5/dotfiles/.zshrc /home/abraxas/
#cp /home/abraxas/start5/dotfiles/.p10k.zsh /home/abraxas/
#cp /home/abraxas/start5/dotfiles/.taskrc /home/abraxas/
#cp /home/abraxas/start5/dotfiles/pcc /home/abraxas/bin
#mv /home/abraxas/start5/dotfiles/bin/* /home/abraxas/bin/
echo
rm -rf /home/abraxas/start
rm -rf $HME/start5
echo
trenner "INSTALL TASKWARRIOR"
pip3 install taskwarrior-inthe.am | tail -f -n5
sudo apt-get install cifs-utils -y | tail -f -n5
#echo; echo GOODSYNC; echo
rm -rf .antigen
printf "${NC}"
cd /home/abraxas
#wget https://www.goodsync.com/download/goodsync-linux-x86_64-release.run
#chmod +x goodsync-linux-x86_64-release.run
#sudo ./goodsync-linux-x86_64-release.run
#sudo gsync /gs-account-enroll=abraxas678@gmail.com
#sudo gsync /activate
 if [[ $(cat /root/.bashrc) = *"switching to [abraxas]"* ]]; then sudo echo "nothing to do"; else echo "echo 'switching to [abraxas] in 5 s'; read -t 5 me; su abraxas" >> /root/.bashrc; fi

curl -sSL https://archive.heckel.io/apt/pubkey.txt | sudo apt-key add -
sudo apt install apt-transport-https | tail -f -n5
sudo sh -c "echo 'deb [arch=amd64] https://archive.heckel.io/apt debian main' > /etc/apt/sources.list.d/archive.heckel.io.list"  
sudo apt update | tail -f -n5
trenner "INSTALL PCOPY"
sudo apt install pcopy | tail -f -n5
#sudo pcopy setup
sudo systemctl enable pcopy
sudo systemctl start pcopy

/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- pip install taskwarrior-inthe.am
/home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- sudo apt-get install cifs-utils -y
rm -rf /home/abraxas/.antigen
#echo; echo GOODSYNC; echo
printf "${NC}"
cd /home/abraxas
#echo; echo "INSTALL GOODSYNC? (y/n)"
#mychoice="n"
#read -n 1 -t 5 mychoice
#if [[ $mychoice = "y" ]]
#then
#  wget https://www.goodsync.com/download/goodsync-linux-x86_64-release.run
#  chmod +x goodsync-linux-x86_64-release.run
#  sudo ./goodsync-linux-x86_64-release.run
#  sudo gsync /gs-account-enroll=abraxas678@gmail.com
#  sudo gsync /activate
#fi
#echo "copy files from gd:dotfiles"
#read -t 10 me
#rclone copy gd:dotfiles /home/abraxas --max-depth 1 --filter-from="/home/abraxas/myfilter.txt" -P
#read -t 10 me
#rclone copy gd:dotfiles/bin /home/abraxas/bin --filter-from="/home/abraxas/myfilter.txt" -P
#read -t 10 me
#rclone copy gd:dotfiles/docker /home/abraxas/docker --filter-from="/home/abraxas/myfilter.txt" -P
#read -t 10 me
#rclone copy gd:dotfiles /home/abraxas --filter-from="/home/abraxas/myfilter.txt" -P
#echo "RCLONE BISYNC DOTFILES (-1)"
#touch /home/abraxas/RCLONE_TEST
#rclone copy RCLONE_TEST gd:dotfiles -P
#rclone copy gd:dotfiles/bin /home/abraxas/bin -P
#rclone copy gd:dotfiles/bisync-filter.txt /home/abraxas -P
#rclone bisync /home/abraxas/ gd:dotfiles --filters-file /home/abraxas/bisync-filter.txt -Pvvv --check-access --resync --skip-links
/home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --title "rclone copy df:.config /home/abraxas/.config --update -Pv" --print "$(rclone copy df:.config /home/abraxas/.config --update -Pv)"
sudo chown $user: -R /home
mkdir /home/abraxas/tmp >/dev/null 2>/dev/null
mkdir /home/abraxas/tmp/restic >/dev/null 2>/dev/null
trenner "RESTIC MOUNT" --style red
restic mount /home/abraxas/tmp/restic &
echo DONE 
echo EXEC ZSH
exec zsh

