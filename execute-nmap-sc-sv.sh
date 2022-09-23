#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <IP address> <ports comma delimited string> <rate> <y/n for -Pn>"
	exit
fi

rateStr="--min-rate= "
pnStr="-Pn "
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)

sudo nmap $pnFlag -sC -sV -oA $CWD/nmap/$dash_delimited_ip-Extensive -p $2 $1
wait

