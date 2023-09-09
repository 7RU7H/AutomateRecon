#!/bin/bash

name=$1
networkCIDR=$2
interface=$3
rate=$4

mkdir -p $name-network/{nmap}

cd $name-network;
touch hosts.txt
sudo nmap -n -sT -p- --min-rate $rate -e $interface -oA nmap/uphosts-allports-cidr $networkCIDR
wait
cat nmap/uphosts-allports-cidr.nmap | grep 'Nmap scan report for' | awk '{print $5}' > hosts.txt
echo ""
echo "Run \`mk-ip-list-to-directories.sh\`"
exit
