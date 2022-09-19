#!/bin/bash
echo; figlet SSH COPY; echo
sleep 1
echo rclone copy df:.ssh $HOME/ssh -P
/home/abraxas/start5/bashfuler.sh rclone copy df:.ssh $HOME/ssh -P
MY_SUDO=$(cat /home/abraxas/mysudo)
$MY_SUDO mv /home/abraxas/ssh/* /home/abraxas/.ssh/ --backup simple
chmod 500 $HOME/.ssh -R
figlet SSH done
