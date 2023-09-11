#!/bin/bash


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <Network Range>"
	echo "$0 10.10.10.0/24"
	exit
fi

dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
CWD=$(pwd)
cat $CWD/masscan/$dash_delimited_network_range-masscan.log | grep 'Host' | awk '{print $4}' | sort -u | tee -a  $CWD/hosts.txt
exit
