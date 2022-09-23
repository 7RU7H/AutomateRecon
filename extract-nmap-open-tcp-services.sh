#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP adress>"
	exit
fi

CWD=$(pwd)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
table_contents=$(cat $CWD/nmap/$dash_delimited_ip-Extensive.nmap | grep "/tcp " | awk '{print $1" "$2" | "$3" | "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "}')
echo "# Nmap Services found on host: $1

Port & Protocol | Service | Version
--- | --- | ---
$table_contents
" > $CWD/nmap/found-services-for-$dash_delimited_ip.md
exit
