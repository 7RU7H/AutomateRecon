#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP> "
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)
smbmap -H $1 | tee -a $CWD/smbmap-output/$dash_delimited_ip
smbmap -H $1 -u "guest"  | tee -a $CWD/smbmap-goutput/$dash_delimited_ip
smbmap -H $1 -u "" -p "" | tee -a $CWD/smbmap-output/$dash_delimited_ip
smbmap -H $1 -u "guest" -p "Password123!" | tee -a $CWD/smbmap-output/$dash_delimited_ip



