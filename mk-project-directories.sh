#!/bin/bash

if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <project name>"
	exit
fi

echo "Tools should only supplyment the manual techinques, tactics and procedures of the user"

echo "Select Port scanner:"
echo "1) Masscan"
echo "2) Naabu"
echo "3) Rustscan"

portscanner=

mkdir $1/{data,wordlists,scripts,shells,nmap,$portscanner,gobuster,feroxbuster,nuclei,nikto,ikescan,cmsseek,gospider} -p
mkdir $1/crackmapexec/{smb-enumeration} -p



