#!/bin/bash
cd ~/tmp
wget https://github.com/bcpierce00/unison/releases/download/v2.52.1/unison-v2.52.1+ocaml-4.04.2+x86_64.linux.tar.gz
tar -xf unison-v2.52.1+ocaml-4.04.2+x86_64.linux.tar.gz
$HOME/bin/sudo.sh mv bin/uni* /usr/bin
