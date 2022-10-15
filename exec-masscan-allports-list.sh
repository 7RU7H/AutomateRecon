#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <list file> <interface> <rate>"
	exit
fi

hosts=$(cat $1)
total=$(wc -l $1)
count=1
for host in $hosts; do
	dash_delimited_ip=$(echo $host | tr -s '.' '-')
	echo "Masscan is scanning $host - Scan number: $count of $total"
	echo ""
	sudo masscan -p0-65535 --rate=$3 -e $2 -oG $dash_delimited_ip/masscan/$dash_delimited_ip-allports-masscan.log $host
	wait
	echo "Masscan has finished scanning $host - Scan number $count of $total"
	echo ""
	let count++
done
exit
