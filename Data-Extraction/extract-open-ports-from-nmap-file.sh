#!/bin/bash

if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <file name when ran nmap>"
        exit
fi

cat nmap/$1.nmap  | grep open | tee -a network-svcs-open.txt
exit
