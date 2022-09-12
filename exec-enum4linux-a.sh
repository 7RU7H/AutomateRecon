#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')
enum4linux -a $1 | tee -a enumFourLinux/efl-a-$dash_delimited_ip



