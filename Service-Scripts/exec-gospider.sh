#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <Valid URL>"
	exit
fi

dash_delimited_naming=$(echo $1 | tr -s '.:/' '-' | awk -F/ '{print $3}')
CWD=$(pwd)i
gospider -d 0 -s "$url" -c 5 -t 100 -d 5 --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt -o $CWD/gospider/$dash_delimited_naming
