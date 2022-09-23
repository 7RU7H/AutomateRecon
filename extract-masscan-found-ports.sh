#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi
CWD=$(pwd)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
LIST=$(cat $CWD/masscan/$1-allports-masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
LENLIST=${#LIST}-1
DECOMMA=${LIST:0:LENLIST}
echo $DECOMMA
exit
