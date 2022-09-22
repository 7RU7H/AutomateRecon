#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <dash-delimited-ip>"
	exit
fi
CWD=$(pwd)
LIST=(cat $CWD/masscan/$1-masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
DECOMMA=${LIST::-1}
echo $DECOMMA
exit

