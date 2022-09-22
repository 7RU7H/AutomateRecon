#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi

CWD=$(pwd)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
ike-scan $1 | tee -a $CWD/ikescan/$dash_delimited_ip



