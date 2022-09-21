#!/bin/bash
cd $HOME
read -p "paste link here" MY_LINK
wget $MY_LINK >imp_files.tar.xz
tar -xf imp_files.tar.xz /

