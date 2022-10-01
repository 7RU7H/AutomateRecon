#!/bin/bash


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <target CIDR> <interface> <rate>"
	exit
fi


dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
CWD=$(pwd)
sudo masscan -oG $CWD/masscan/$dash_delimited_network_range-masscan.log --top-ports 100 -e $interface --rate $rate $1
