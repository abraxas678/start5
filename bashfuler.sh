#!/bin/bash
ts=$(date +"%s")
echo "tasks:" >$ts.yml
v1="$@"
#t1=$(echo $v1 | sed 's/&&.*//' | sed 's/;.*//')
x=0
i=1
while [[ $x -eq 0 ]]; do
  line=$(echo $v1 | sed 's/\&\&/\&/g' > my_bashful_line; cut my_bashful_line -d '&' -f$i)
  echo line $line
  if [[ $line != "" ]]; then
  echo "    - name: $line" >>$ts.yml
  echo "      cmd: $line" >>$ts.yml
  echo " " >>$ts.yml
  else
    x=1
  fi
  i=$((i+1))
done
rm -f my_bashful_line
bashful run $ts.yml
rm -f $ts.yml
