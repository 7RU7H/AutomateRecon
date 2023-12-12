#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <URL>"
	echo "Nuclei usage Offsec exam friendly with \`-etags expliot\` used"
	exit
fi

URL=$1
IP=$(echo $URL | awk -F/ '{print $3}')
nuclei -u $URL -debug -etags exploit,cve,rce,sqli,xss,lfi,ssti,ssrf,csrf,xxe,traversal,crlf,csv,injection,pollution,smuggling -me nuclei
wait
gospider -d 0 -s "$URL" -c 5 -t 100 -d 5 --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt -o gospider
wait
nikto -h $IP -o nikto/http.txt 
wait
gobuster dir -u $URL -w /usr/share/seclists/Discovery/Web-Content/raft-small-directories-lowercase.txt -o www-root.gobuster
wait
echo ""
echo "Done simple automated enumeration - remember maunal enumeration is always best"
echo ""
exit
