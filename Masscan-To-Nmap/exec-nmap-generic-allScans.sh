#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <IP address> <rate integer>"
	exit
fi

cwd=$(pwd)
sudo nmap -F -n --min-rate $2 $1 2>&1 > /tmp/nmap-err
sn_output=$(cat /tmp/nmap-err)
if [[ "$sn_output" =~ ."try -Pn". ]]; then
	nmap_pn_flag="-Pn"
	echo ""
	echo "Host: $1 requires -Pn flag!"
	echo ""
else
	nmap_pn_flag=""
fi
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
list=$(cat $cwd/masscan/$dash_delimited_ip-allports-masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
ports=${list:0:${list} - 1 }
sudo nmap $nmap_pn_flag -sC -sV -oA $cwd/nmap/$dash_delimited_ip-Extensive-Found-Ports --min-rate $2 -p $ports $1
wait
sudo nmap $nmap_pn_flag --script discovery -oA $cwd/nmap/$dash_delimited_ip-Discovery --min-rate $2 -p $ports $1
wait
sudo nmap $nmap_pn_flag --script vuln -oA $cwd/nmap/$dash_delimited_ip-Vuln --min-rate $2 -p $ports $1
wait
sudo nmap $nmap_pn_flag -sC -sV -oA $cwd/nmap/$dash_delimited_ip-Extensive-Allports --min-rate $2 -p- $1
wait
sudo nmap $nmap_pn_flag -sU -oA $cwd/nmap/$dash_delimited_ip-UDP --min-rate $2 -p- $1
wait
echo ""
echo "Nmap has finish all 5 Scans against $1"
echo ""
rm /tmp/nmap-err
exit



