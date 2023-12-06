#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Append all Screenshots in order of when they were taken!"
	echo "Usage: $0 <File Name>"
	exit
fi

CWD=$(pwd)
SS=$(ls -tlr $CWD/Screenshots)
for png in SS; do
	echo "![]($png)" >> $1
	echo "" >> $1
done
echo "Appended all Screenshots to $1"
exit
	
