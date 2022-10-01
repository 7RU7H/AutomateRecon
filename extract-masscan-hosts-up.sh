#!/bin/bash


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <Network Range>"
	exit
fi

dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
CWD=$(pwd)
cat $CWD/masscan/$dash_delimited_network_range-masscan.log | awk '{print $4}' | grep -v 'TCP\|scan\|at' | sort -u > $CWD/masscan/masscan-found-ips.txt
exit
