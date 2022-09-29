#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <IP> <Ports string> <rate integer>"
	exit
fi


dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)

sudo nmap -sC -sV -oA $CWD/nmap/Extensive --min-rate $2 -p $2 $1
wait
sudo nmap --script discovery -oA $CWD/nmap/Discovery --min-rate $2 -p $2 $1
wait
sudo nmap --script vuln -oA $CWD/nmap/Vuln --min-rate $2 -p $2 $1
wait
sudo nmap -sU -oA $CWD/nmap/UDP --min-rate $2 -p- $1
wait
exit