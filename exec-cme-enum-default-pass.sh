#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <IP> <users.txt path> <Default Password>"
	exit
fi

dash_delimited_ip=$(echo $1 | tr -s '.' '-')
CWD=$(pwd)
list=(ssh smb winrm ldap mssql) 
mkdir $CWD/cme

for i in $list; do
	crackmapexec $list $1 -u $2 -p '$3'  |  tee -a $CWD/cme/cme-enum-default-pass  
	wait
done


