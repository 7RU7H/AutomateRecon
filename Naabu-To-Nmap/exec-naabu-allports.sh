#!/bin/bash

if [ "$#" -eq 0 ]; then	
	echo "Usage: $0 <rate> <workers> <interface> <target-ip>"
	echo "Defaults:   25       5         N/A        N/A"
	echo ""
	echo " Requirements:"
	echo " - mkdir naabu in $(pwd)"
	echo " - Rate and Worker integers"
	echo " - Password for sudo"
	exit
fi

dash_delimited_ip=$(echo $4 | tr -s '.' '-')
sudo naabu -host $4 -p 0-65535 -i $3 -c $2 -rate $1 -verify -stats -nc -o $(pwd)/naabu/$dash_delimited_ip-allports-naabu
wait
exit
