#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <Nmap.gnmap>"
	exit
fi
CWD=$(pwd)
svcs=$(cat $CWD/nmap/$1 | grep Ports | cut -d : -f 3 | tr -s ',' '\n' | tr -s '/' ' ') 
echo $svc >> $CWD-Notes.md
exit


