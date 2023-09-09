#!/bin/bash

if [ "$#" -ne 3 ]; then
        echo "Usage: $0 <CDIR range> <interface> <rate integer>"
	echo "This script is to used when the masscan varient fails it will:"
	echo "Scan top 1000 port only to check whether a IP with in network range is up"
	echo "use : \`Data-Extraction/extract-ips-from-nmap-cidr-file\` to get IPs for list"
        exit
fi

dash_delimited_range=$(echo $1 | tr -s '.' '-' | sed 's/\//-cdir/g')
sudo nmap -F -n --min-rate $3 -e $2 -oG $dash_delimited_range $1 
wait
echo "use: \`Data-Extraction/extract-ips-from-nmap-cidr-file\` to get IPs for list"
echo "then.."
echo "use: \`Directory-Management/mk-ip-list-to-directories.sh\`"
exit
