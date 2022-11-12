#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <list file> <interface> <rate integer>"
	exit
fi

hosts=$(cat $1) 
total=$(wc -l $1)
count=1
for host in $hosts; do
	sudo nmap -F -n --min-rate $3 $host 2>&1 > /tmp/nmap-err
	sn_output=$(cat /tmp/nmap-err)
	if [[ "$sn_output" =~ ."try -Pn". ]]; then
		nmap_pn_flag="-Pn"
		echo ""
		echo "Host: $host requires -Pn flag!"
		echo ""
	else
		nmap_pn_flag=""
	fi
	dash_delimited_ip=$(echo $host | tr -s '.' '-')
	sudo nmap $nmap_pn_flag -sU -oA $dash_delimited_ip/nmap/$dash_delimited_ip-UDP -e $2 --min-rate $3 -p- $host
	wait
	echo ""
	echo "Nmap has finish UDP Scan against $host - Scan number $count of $total"
	echo ""
	let count++
	rm /tmp/nmap-err
done
exit



