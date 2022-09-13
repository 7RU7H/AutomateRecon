#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <project directory> <dash-delimited-ip>"
	exit
fi

LIST=(cat $1/masscan/$2-masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
DECOMMA=${LIST::-1}
echo $DECOMMA
exit

