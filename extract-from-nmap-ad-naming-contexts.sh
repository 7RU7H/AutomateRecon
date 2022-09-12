#!/bin/bash

if [ "$#" -ne 0 ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi

# Naming Context Extraction
# Use regular .nmap
naming_contexts=$(cat nmap/Discovery.nmap | grep naming | awk '{print $2 $3}')
