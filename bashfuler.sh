#!/bin/bash
ts=$(date +"%s")
echo '$include: myconfig.yml' >$ts.yml
echo " " >>$ts.yml
echo "tasks:" >>$ts.yml
v1="$@ &&"
#t1=$(echo $v1 | sed 's/&&.*//' | sed 's/;.*//')
x=0
i=1
echo $v1 | sed 's/\&\&/\&/g' > my_bashful_line; 
while [[ $x -eq 0 ]]; do
  line=$(cut my_bashful_line -d '&' -f$i)
#  echo line $line
  if [[ $line != "" ]]; then
  echo "    - name: $line" >>$ts.yml
  echo "      cmd: $line" >>$ts.yml
  echo " " >>$ts.yml
  else
    x=1
  fi
  i=$((i+1))
#  echo i $i
done
rm -f my_bashful_line
bashful run $ts.yml
rm -f $ts.yml
