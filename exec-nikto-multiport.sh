#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <IP address> <>"
	exit
fi


for port in $ports; do
	nikto -h $1 -o nikto/


