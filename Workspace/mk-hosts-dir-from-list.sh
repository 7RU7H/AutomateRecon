#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <file containing a list ips>"
	exit
fi

hosts=$(cat $1)
for host in $hosts; do
	dash_delimited_ip=$(echo $host | tr -s '.' '-')
	mkdir $dash_delimited_ip/{nmap,masscan,Screenshots,data} -p
	touch $dash_delimited_ip/$dash_delimited_ip-Notes.md
done
exit
