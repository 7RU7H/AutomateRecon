#!/bin/bash


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <target> <interface> <rate>"
	exit
fi


rate_flag="--rate="
interface_flag="-e "
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
sudo masscan -p0-65535 -oG masscan/$dash_delimited_ip-allports-masscan.log $interface $rate $1
