#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <file containing a list ips>"
	exit
fi

hosts=$(cat $1)
for host in $hosts; do
	dash_delimited_ip=$(echo $host | tr -s '.' '-')
	mkdir $dash_delimited_ip/{nmap,masscan,Screenshots,data} -p
	touch $dash_delimited_ip/$dash_delimited_ip-Notes.md
	echo "## Intel

IP: $host
OS:
Arch:
Hostname:
DNS:
Domain:
Domain SID:
Machine Purpose:
Services:
Service Languages:
Email Address & Formatting:
Username Format:


## Machine Connects list and reason:

[[]] - Reason X

## Objectives
What do have in the solutions inventory to meet larger objective?

## Solution Inventory Map
What edges do you have?


## Data Collected

#### Credentials

#### HUMINT

#### Local Inventory



#### Todo List



#### Timeline of tasks completed

" > $dash_delimited_ip/$dash_delimited_ip-Notes.md
 
done
exit
