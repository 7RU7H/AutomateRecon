#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <file containing a list ips> <parent directory name>"
	exit
fi

mkdir $2
hosts=$(cat $1)
cd $2
for host in $hosts; do
	dash_delimited_ip=$(echo $host | tr -s '.' '-')
	mkdir $dash_delimited_ip/{nmap,masscan,Screenshots,data} -p
	touch $dash_delimited_ip/$dash_delimited_ip-Notes.md
done
mv $1 $2
echo "Moved the list into the supplied parent directory along with creating sub directories for each ip"
exit
