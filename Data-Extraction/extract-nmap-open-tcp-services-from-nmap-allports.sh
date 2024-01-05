#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi

CWD=$(pwd)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
table_contents=$(cat $CWD/nmap/$dash_delimited_ip-Extensive-Found-Ports.nmap | grep "/tcp " | awk '{print $1" "$2" | "$3" | "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "}')
list_for_notes=$(cat $CWD/nmap/$dash_delimited_ip-Extensive-Found-Ports.nmap | grep "/tcp " | awk -F/ '{print "- "$1}')
echo "# Nmap Services found on host: $1

Port & Protocol | Service | Version
--- | --- | ---
$table_contents

$list_for_notes


" > $CWD/nmap/found-services-for-$dash_delimited_ip.md




exit
