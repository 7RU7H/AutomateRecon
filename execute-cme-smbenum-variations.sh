#!/bin/bash

if [ "$#" -ne 1  ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi


dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)
mkdir -p $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $1 --shares | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $IP -u '' -p '' --pass-pol | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $1 --shares -u '' | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $1 --shares -u 'Test' | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $1 --shares -u 'Test' -p '' | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
echo "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip
crackmapexec smb $IP -u "" up "" | tee -a $CWD/crackmapexec/smb-enumeration/$dash_delimited_ip

