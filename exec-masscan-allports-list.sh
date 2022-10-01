#!/bin/bash


if [ "$#" -eq 3 ]; then
	echo "Usage: $0 <exec-masscan-allports.sh> <interface> <rate>"
	exit
fi

dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
CWD=$(pwd)
ips=$($CWD/masscan/masscan-found-ips.txt)
for ip in $ips; do
	$1 $ip $2 $3
done
exit
