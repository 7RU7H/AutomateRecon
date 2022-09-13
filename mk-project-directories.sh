#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <project name>"
	exit
fi

mkdir $1
cd $1;
mkdir enumFourLinux
mkdir masscan
mkdir nmap



