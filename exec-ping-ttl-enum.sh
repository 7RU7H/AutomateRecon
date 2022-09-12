#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <IP address>"
	exit
fi

STARTTIME=$(date)
dash_delimited_ip=$(echo $1 | tr -s '.' '-')
echo "Conducting Ping test against $1.."
echo
PINGOUT=$(ping -W 30 -c 1 $1) # check output if -Pn needed; if just exit - # TODO ttl for os detection
wait
echo "Ping test complete against $1!"
echo
PINGRECV=$(echo $PINGOUT | cut -d ' ' -f 40)
TTLFIELD=$(echo $PINGOUT | awk '{print $1}' | tr -d '[A-Za-z-\n]' | cut -c -2)
if ["$PINGRECV" != "3"]
then
        echo "Ping test recieved $PINGRECV packets"
        echo
	echo "Ping test OS detection: $TTLFIELD"
	echo
fi
exit


