#!/bin/bash
CWD=($pwd)
cat $CWD/nmap/*xt*.nmap  | grep open | tee -a network-svcs-open.txt
exit
