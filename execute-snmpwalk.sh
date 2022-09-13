#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <IP address> <Project Directory>"
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')
snmpwalk -c public -v2c $1 -L $2/snmpwalk/$dash_delimited_ip-snmpwalk.log

