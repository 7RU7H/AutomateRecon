#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <list file> <rate integer>"
	exit
fi

hosts=$(cat $1) 
total=$(wc -l $1)
count=1
#nmap_pn_flag="" 
for host in $hosts; do
	sudo nmap -F -n --min-rate $2 $host 2>&1 > /tmp/nmap-err
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
	list=$(cat $dash_delimited_ip/masscan/$dash_delimited_ip-allports-masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
	ports=${list:0:${list} - 1 }	
	sudo nmap $nmap_pn_flag -sC -sV -oA $dash_delimited_ip/nmap/$dash_delimited_ip-Extensive-Allports --min-rate $2 -p- $host
	wait
	sudo nmap $nmap_pn_flag -sU -oA $dash_delimited_ip/nmap/$dash_delimited_ip-UDP --min-rate $2 -p- $host
	wait
	echo ""
	echo "Nmap has finish all 5 Scans against $host - Scan number $count of $total"
	echo ""
	let count++
	rm /tmp/nmap-err
done
exit



