#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <IP address> <RID Range>"
	exit
fi

if [ "$2" -gt 999999 ]; then
	echo "Invalid RID Range"
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')

enum4linux -U -S -P -G -o -d -l -n -A -r -K $2 $1 | tee -a enumFourLinux/efl-rid-$dash_delimited_ip



