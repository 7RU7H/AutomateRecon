#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <project name>"
	exit
fi

mkdir $1/{nmap,masscan,feroxbuster,nuclei,nikto} -p



