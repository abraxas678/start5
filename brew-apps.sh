#!/bin/bash
#  ######################################## BREW BASED SOFTWARE ########################################
  /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --panel-style blue --style green --print "INSTALL BREW BASED SOFTWARE"
  countdown 1
  pueue group add system-setup >/dev/null 2>/dev/null
  pueue parallel 1 -g system-setup 
  pueue add -g system-setup -- brew install gcalcli
  pueue add -g system-setup -- brew install fzf
  pueue add -g system-setup -- 'yes | $(brew --prefix)/opt/fzf/install'
  echo; pueue status -g system-setup 
  countdown 5
 /home/linuxbrew/.linuxbrew/bin/rich --panel rounded --style blue -u
################################################################################################
