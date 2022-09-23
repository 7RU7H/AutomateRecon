#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <full url including protocol>"
	exit
fi

dash_delimited_naming=$(echo $1 | tr -s '.:' '-' | awk -F/ '{print $3}')
CWD=$(pwd)
nuclei -me $CWD/nuclei-$dash_delimited_naming -u $1
wait
exit



