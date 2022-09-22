#!/bin/bash

if [ "$#" -eq 0 ]; then	
	echo "Usage either:"
	echo "Single flag: without interface (will use default interface) and rate: $0 <target>"
	echo "Three flags: $0 <target> <interface> <rate>"
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)
if [ "$#" -gt 1 ]; then
	if [ "$#" -eq 3 ]; then
		sudo masscan -p0-65535 --rate=$3 -e $2 -oG $CWD/masscan/$dash_delimited_ip-allports-masscan.log $1
	else
		echo "Usage either:"
		echo "Single flag: without interface and rate(default interface and rate): $0 <target>"
		echo "Three flags: $0 <target> <interface> <rate>"
		exit
	fi
else
	sudo masscan -p0-65535 -oG $CWD/masscan/$dash_delimited_ip-allports-masscan.log $1
fi
