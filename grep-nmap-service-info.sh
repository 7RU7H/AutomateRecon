#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi

#TCPSERVICE=$(grep nmap/Extensive.nmap -e "/tcp \+open" |
# Protocol https/http or both flag for nuclei
TCPCOUNT=$(grep $1/nmap/Extensive.nmap -e "/tcp \+open" | wc -l)
TCPSTR=$(grep $1/nmap/Extensive.nmap -e "/tcp \+open" | tr -d '[a-zA-Z]/._:' | cut -d ' ' -f 1 )
TCPCOMMA=$(sort $TCPSTR | uniq | tr -s '\n' ', ')
TCPDECOMMA=${TCPCOMMA::-1}
TCPLIST="T:$TCPDECOMMA"

UDPCOUNT=$(grep $1/nmap/UDP.nmap -e "/udp \+open" | wc -l)
UDPSTR=$(grep $1/nmap/UDP.nmap -e "/udp \+open" | tr -d '[a-zA-Z]/._:' | cut -d ' ' -f 1 )
UDPCOMMA=$(sort $UDPSTR | uniq | tr -s '\n' ', ')
UDPDECOMMA=${UDPCOMMA::-1}
UDPLIST="U:$UDPDECOMMA"

FULLPORTLIST="$TCPLIST $UDPLIST"



