#!/bin/bash


if [ "$#" -eq 3 ]; then
	echo "Usage: $0 <target CIDR> <interface> <rate>"
	exit
fi


dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
CWD=$(pwd)
sudo masscan -oG $CWD/masscan/$dash_delimited_network_range-masscan.log --top-ports 100 -e $2 --rate $3 $1
