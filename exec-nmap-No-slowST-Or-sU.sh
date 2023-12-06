#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <IP address> <rate integer> <network interface>"
	exit
fi


dash_delimited_ip=$(echo $1 | tr -s '.' '-')
cwd=$(pwd)
sudo nmap -F -n --min-rate $2 -e $3 $1 2>&1 > /tmp/nmap-err-$dash_delimited_ip
sn_output=$(cat /tmp/nmap-err)
if [[ "$sn_output" =~ ."try -Pn". ]]; then
	nmap_pn_flag="-Pn"
	echo ""
	echo "Host: $1 requires -Pn flag!"
	echo ""
else
	nmap_pn_flag=""
fi

sudo nmap $nmap_pn_flag -p- -vv --min-rate $2 -e $3 -oA $cwd/nmap/$dash_delimited_ip-All-TCP-Ports $1
wait
list=$(cat $cwd/nmap/$dash_delimited_ip-All-TCP-Ports.nmap | grep open | awk -F/ '{print $1}' | tr -s '\n' ',');
ports=${list:0:${list} - 1 };
sudo nmap $nmap_pn_flag -sC -sV -oA $cwd/nmap/$dash_delimited_ip-Extensive-Found-Ports --min-rate $2 -e $3 -p $ports $1
wait
sudo nmap $nmap_pn_flag --script discovery -oA $cwd/nmap/$dash_delimited_ip-Discovery --min-rate $2 -e $3 -p $ports $1
wait
sudo nmap $nmap_pn_flag --script vuln -oA $cwd/nmap/$dash_delimited_ip-Vuln --min-rate $2 -e $3 -p $ports $1
wait
echo ""
echo "Nmap has finish all 4 Scans against $1"
echo ""
echo "!!WARNING!! - Rescan on these ports that were found on the automated slow rescanning for TCP - !!WARNING!!"
echo ""
cat $cwd/nmap/$dash_delimited_ip-All-TCP-slow
echo ""
echo "!!WARNING!! - Rescan on these ports that were found on the automated slow rescanning for TCP - !!WARNING!!"
rm /tmp/nmap-err-$dash_delimited_ip
exit



