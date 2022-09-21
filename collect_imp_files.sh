#!/bin/bash
cd $HOME
mkdir $HOME/tmp >/dev/null 2>/dev/null
mkdir $HOME/tmp/imp_files >/dev/null 2>/dev/null
mkdir $HOME/tmp/imp_files/home >/dev/null 2>/dev/null
mkdir $HOME/tmp/imp_files/home/.config >/dev/null 2>/dev/null
mkdir $HOME/tmp/imp_files/home/bin >/dev/null 2>/dev/null

cp $HOME/.config/*.age $HOME/tmp/imp_files/home/.config/
cp $HOME/.config/*.sh $HOME/tmp/imp_files/home/.config/
cp $HOME/.config/rclone $HOME/tmp/imp_files/home/.config/ -r
cp $HOME/bin/*.sh $HOME/tmp/imp_files/home/bin/
cp $HOME/* $HOME/tmp/imp_files/home/
XZ_OPT=-9 tar --exclude="*/.git" --exclude-caches --exclude-vcs-ignores -Jcvf imp_files.tar.xz $HOME/tmp/imp_files

rclone move $HOME/imp_files.tar.xz od:tmp -P
MY_LINK=$(rclone link od:tmp/imp_files.tar.xz)
echo $MY_LINK | xclip
echo $MY_LINK
