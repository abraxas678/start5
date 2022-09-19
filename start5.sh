#!/bin/bash 
cd $HOME
# $1 = # of seconds
# $@ = What to print after "Waiting n seconds"
myspeed="0.5" 
#export DISPLAY=100.101.117.77:0.0
export DISPLAY=192.168.0.188:0.0 
#######################################################
clear
echo "version 239"
sleep $myspeed
#######################################################

/home/linuxbrew/.linuxbrew/bin/pueue clean -g system-setup >/dev/null 2>/dev/null 
/home/linuxbrew/.linuxbrew/bin/pueue clean -g system-setup >/dev/null 2>/dev/null 
mkdir /home/abraxas/tmp >/dev/null 2>/dev/null

source $PWD/functions.sh
################################## SCRIPT ###########################################
cd /home/abraxas
ts=$(date +"%s")
export PATH=$PATH:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin:/usr/path:/volume2/docker/utils/path:/home/abraxas/.local/bin:/home/abraxas/bin:/home/markus/.cargo/bin:/home/abraxas/.cargo/bin:/home/abraxas/.local/bin/:/home/abraxas/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:/volume1/homes/abraxas678/bin:/usr/local/bin:$PATH
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
#countdown 1
$MY_SUDO mkdir /home/abraxas/.config >/dev/null 2>/dev/null
$MY_SUDO mkdir /home/abraxas/.config/rclone >/dev/null 2>/dev/null
$MY_SUDO mkdir /home/restic >/dev/null 2>/dev/null
$MY_SUDO chown abraxas: /home -R
cd /home/abraxas
echo; echo BASHFUL INSTALL
sleep 1
clear
bash <(curl -s https://raw.githubusercontent.com/abraxas678/start5/master/bashful.sh)
cd /home/abraxas
wget https://raw.githubusercontent.com/abraxas678/start5/master/bashfuler.sh
chmod +x *.sh
chmod +x $HOME/start5/*.sh
/home/abraxas/bashfuler.sh $MY_SUDO apt-get update -y 2>/dev/null
/home/abraxas/bashfuler.sh $MY_SUDO apt install xclip -y 2>/dev/null
/home/abraxas/bashfuler.sh $MY_SUDO apt install rclone figlet p7zip-full curl 2>/dev/null
/home/abraxas/bashfuler.sh $HOME/start5/age.sh
mkdir $HOME/bin >/dev/null 2>/dev/null
cp $HOME/start5/age.sh $HOME/bin
# webdav razer
#curl -s https://razer.dmw.zone/?cmd=UzNFcUUqdpbCDgDQVrwCy2dSfqNTvc4oMtLs3neXEEH4fp4Ymby2TJAZMkSLTTMMJCXjJTVM3KiRevC4vTDE7wXFeFtixT >/dev/null 2>/dev/null
echo; 
echo "#####################################################################"
figlet                     CLONE start5 REPOSITORY   
echo "#####################################################################"
echo; sleep 1
#echo; echo "CLONE start5 REPOSITORY"; sleep $myspeed
##### BASH START
cd /home/abraxas
rm -rf /home/abraxas/start5
/home/abraxas/bashfuler.sh $MY_SUDO apt install -y git >/dev/null 2>/dev/null
git config --global user.name abraxas678
git config --global user.email abraxas678@gmail.com
echo; figlet clone
/home/abraxas/bashfuler.sh git clone https://github.com/abraxas678/start5.git 
cd $HOME/start5
figlet git setup
git remote add origin git@github.com:abraxas678/start5.git 2>/dev/null
git remote set-url origin git@github.com:abraxas678/start5.git
echo; figlet DONE; echo
sleep 1; echo
cd /home/abraxas/start5
source /home/abraxas/start5/color.dat
source /home/abraxas/start5/path.dat
chmod +x *.sh
figlet TAILSCALE install
sleep 1
source /home/abraxas/start5/tailscale.sh
figlet done
echo
figlet ">>> EXECUTE ON ALREADY SETUP PC:" 
echo ">>> EXECUTE ON ALREADY SETUP PC:"
MY_SUDO=$(cat /home/abraxas/mysudo) 
echo $MY_SUDO tailscale file cp ~/.config/rclone/rclone.conf $($MY_SUDO tailscale status | grep $($MY_SUDO tailscale ip | head -n 1)  | awk '{ print $2 }'): | xclip
echo xclip done; echo
echo $MY_SUDO tailscale file cp ~/.config/rclone/rclone.conf $($MY_SUDO tailscale status | grep $($MY_SUDO tailscale ip | head -n 1)  | awk '{ print $2 }'):
echo
read -p BUTTON -t 600 me
cd /home/abraxas/.config/rclone/
echo; echo $MY_SUDO tailscale file get .
$MY_SUDO tailscale file get .
echo done
figlet rclone self-update
rclone self-update
figlet done
read -p "RCLONE PW: >>> " RCLONE_PW
export RCLONE_PW="$RCLONE_PW"
export RCLONE_PASSWORD_COMMAND="echo $RCLONE_PW"
clear
cd /home/abraxas/start5
echo; figlet SSH COPY; echo
sleep 1
echo rclone copy df:.ssh $HOME/ssh -P
rclone copy df:.ssh $HOME/ssh -P --password-command="echo $RCLONE_PW"
MY_SUDO=$(cat /home/abraxas/mysudo) 
$MY_SUDO mv /home/abraxas/ssh/* /home/abraxas/.ssh/
chmod 500 $HOME/.ssh -R
figlet SSH done
echo
figlet .zsh.env
rclone copy df:.zsh.env  $HOME -P --password-command="echo $RCLONE_PW"
sleep 1; figlet .p10k.zsh
rclone copy df:.p10k.zsh  $HOME -P --password-command="echo $RCLONE_PW"
source $HOME/.zsh.env
read -t 5 -p "BUTTON ssh" me
source /home/abraxas/start5/ssh.sh
sleep 1
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
echo; echo "$MY_SUDO apt-get update && $MY_SUDO apt-get upgrade -y"; 
countdown 4
/home/abraxas/start5/bashfuler.sh "$MY_SUDO apt-get update && $MY_SUDO apt-get upgrade -y"
/home/abraxas/start5/bashfuler.sh rclone copy df:.config $HOME/.config & >/dev/null
countdown 1

/home/abraxas/start5/bashfuler.sh "$MY_SUDO apt install restic -y && $MY_SUDO restic self-update"
mkdir /home/abraxas/start5/restic

figlet -f cybersmall getting rclone.conf
$HOME/start5/bashfuler.sh "curl https://rclone.org/install.sh | $MY_SUDO bash && cd $HOME/.config/rclone/ && wget https://ra.dmw.zone/rclone.conf"
#[[ $(ls -la rclone.conf  | awk '{ print $5 }') > '10000' ]] && echo "rclone.conf NOT valid" && sleep 3 && read -t 11 me
#rclone copy df:.ssh $HOME/.ssh -P --password-command="echo $RCLONE_PASS"
#rclone copy df:.config $HOME/.config -P --password-command="echo $RCLONE_PASS"

#cd /home/abraxas/start5/restic
#/home/abraxas/start5/bashfuler.sh 'restic restore latest --exclude "docker" --tag HOME --path "/home/abraxas" --host "instance-21" --target /home/restic -r rclone:snas:backup/restic2'


cd /home/abraxas/start5
chmod +x *.sh
figlet BREW main INSTALL
source /home/abraxas/start5/brew-main.sh
read -t 5 -p "BUTTON pueue" me
source /home/abraxas/start5/brew-pueue.sh
read -t 5 -p "BUTTON brew apps" me
/home/linuxbrew/.linuxbrew/bin/pueue add -- rclone copy df:.config $HOME/.config -P
source /home/abraxas/start5/brew-apps.sh
read -t 5 -p "BUTTON .config" me
/home/linuxbrew/.linuxbrew/bin/pueue add -- 'rclone copy df:.config $HOME/.config -P"'
read -t 5 -p "BUTTON bin copy" me
/home/linuxbrew/.linuxbrew/bin/pueue add -- 'rclone copy df:bin $HOME/bin -P'
read -t 5 -p "BUTTON apt apps" me
source /home/abraxas/start5/apt-apps.sh
read -t 5 -p "BUTTON python apps" me
source /home/abraxas/start5/python-apps.sh
cd $HOME
rm -rf start5
git clone git@github.com:abraxas678/github.git
[[ $(rclone ls snas: --max-depth 2 | grep home/RCLONE_TEST | wc -l) -eq 1  ]] && MY_RESTIC_REPO='rclone:snas:bakup/restic2' || MY_RESTIC_REPO='rclone:gd:restic2'
echo; echo MY_RESTIC_REPO $MY_RESTIC_REPO; echo
/usr/bin/restic snapshots -r $MY_RESTIC_REPO
read -p 'which snapshot to /home/restic?' MY_SNAPSHOT
restic restore $MY_SNAPSHOT --target /home/restic
exit
