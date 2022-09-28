#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi

CWD=$(pwd)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
snmpwalk -c public -v2c $1 -L f $CWD/snmpwalk/$dash_delimited_ip-snmpwalk.log

