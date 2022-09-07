echo "#####################################################################"
echo "                          INSTALL BREW"
echo "#####################################################################"
echo; sleep 2
countdown 1
  
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" | tail -f -n5
  echo; countdown 1
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shelle /home/linuxbrew/.linuxbrew/binnv)"' >> /home/abrax/.zprofile
  [[ $MY_PUEUE_INST -eq 1 ]] && /home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" | tail -f -n5
  [[ $MY_PUEUE_INST -eq 1 ]] && /home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- sudo apt-get install build-essential -y || sudo apt-get install build-essential -y | tail -f -n5
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  [[ $MY_PUEUE_INST -eq 1 ]] && /home/linuxbrew/.linuxbrew/bin/pueue add -g system-setup -- brew install gcc || brew install gcc | tail -f -n5
echo "#####################################################################"
echo "                           INSTALL PUEUE"
echo "#####################################################################"
echo; sleep 2
  countdown 1
  brew install pueue | tail -f -n5
  echo; echo "INSTALL RICH-CLI"
  brew install rich | tail -f -n5
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue --print "rich installed" -u
  countdown 1
  sudo chown -R abraxas: /run/user
  sudo chown -R abraxas: /home
  sudo chmod +x /home/abraxas/.cargo/bin/pueue
  sudo chmod +x /home/abraxas/.cargo/bin/pueued
  sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueue
  sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueued
  source $HOME/start5/path.dat
  echo; echo "pueued -d"
  /home/linuxbrew/.linuxbrew/bin/pueued -d
  /home/linuxbrew/.linuxbrew/bin/pueue start
  #/home/linuxbrew/.linuxbrew/bin/pueue

x=0
rm -f $HOME/tmp/pueuestatus.txt
pueue-init

#while [[ $x -eq 0 ]]; do
#echo "PUEUE INIT"
#countdown 1
#export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
#/home/linuxbrew/.linuxbrew/bin/pueue status >>pueuestatus.txt 2>>pueuestatus.txt
#[[ $(cat $HOME/tmp/pueuestatus.txt) = *"Failed to initialize client"* ]] &&  /home/linuxbrew/.linuxbrew/bin/pueued -d && sleep 2 &&  /home/linuxbrew/.linuxbrew/bin/pueue status
#[[ $(cat $HOME/tmp/pueuestatus.txt) = *"Permission denied"* ]] && sudo chown -R abraxas: /run/user && sudo chmod +x /home/linuxbrew/.linuxbrew/bin/pueue &&  /home/linuxbrew/.linuxbrew/bin/pueued -d && sleep 2 &&  /home/linuxbrew/.linuxbrew/bin/pueue status
#[[ $(cat $HOME/tmp/pueuestatus.txt) = *"Group"* ]] && x=1
#printf $HOME/tmp/pueuestatus.txt; cat $HOME/tmp/pueuestatus.txt
#sleep 1
#done
rm -f $HOME/tmp/pueuestatus.txt
/home/linuxbrew/.linuxbrew/bin/pueue status | tails -n 10
trenner Pueue initialized
countdown 1