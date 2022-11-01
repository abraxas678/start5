#!/bin/bash
cd $HOME
read -p "paste link here >> " MY_LINK
wget $MY_LINK >$HOME/.config/rclone/rclone.conf
rclone move gdsec:tmp/im_files.tar.xz . -P
tar -xf imp_files.tar.xz /

