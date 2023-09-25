#!/bin/bash

if [ "$#" -ne 3 ]; then
        echo "Usage: $0 <Directory of AutomateRecon> <interface> <rate integer>"
	echo "Run from project directory containing a hosts.txt"
        echo "Run Workspace/mk-* scripts!"
	exit
fi


AutomateReconDir=$1
hosts=$(cat hosts.txt)
interface=$2
rate=$3
for ip in $hosts; do
	dash_delimited_ip=$(echo $ip | tr -s '.' '-')	
	sudo nmap -Pn -p- $ip --min-rate $rate -e $interface -oA $dash_delimited_ip/nmap/allports -v
	wait
	cd $dash_delimited_ip
	$AutomateReconDir/Data-Extraction/extract-open-ports-from-nmap-file.sh allports
	list=$(cat network-svcs-open.txt | awk -F/ '{print $1}' |  tr -s '\n' ', ')
	ports=${list:0:${list }- 1 }
	sudo nmap -Pn -sC -sV -p $ports $ip --min-rate $rate -e $interface -oA $dash_delimited_ip/nmap/Extensive
	wait
	cd ../
done
