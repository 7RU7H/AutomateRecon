#!/bin/bash

if [ "$#" -ne 2 ]; then
		echo "Usage: $0 <target address> <rate amount>"
		exit
fi

if [[ "$EUID" = 0 ]]; then
    echo "(1) Currently root"
else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "(2) Correct password"
    else
        echo "(3) Incorrect password"
        exit 1
    fi
fi

echo ""
# Run a port scan and output error, if require -Pn to err file
sudo nmap -F -n --min-rate $2 $1 2>&1 > /tmp/nmap-err

sn_output=$(cat /tmp/err)

if [[ "$sn_output" == *"try -Pn"* ]]; then
	echo "The host: $1 requires: -Pn flag"
else
	echo "The host $1 does not require -Pn flag" 
fi
rm /tmp/nmap-err
echo ""
exit


