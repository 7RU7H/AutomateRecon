#!/bin/bash


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <target CIDR> <interface> <rate>"
	exit
fi

rate_flag="--rate="
interface_flag="-e "
sudo masscan -oG masscan/cidr-$1-masscan.log $interface $rate $1
