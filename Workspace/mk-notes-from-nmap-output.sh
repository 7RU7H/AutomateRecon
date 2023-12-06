#!/bin/bash



echo "Run from project directory with nmap/$FILE.nmap as a sub directory."

BOXNAME=$(ls -1 Notes/ | grep -v 0 | awk -F- '{print $1}')

TCPCOUNTSTR=$(cat nmap/*Ext*.nmap | grep -e "/tcp \+open" | wc -l)
TCPSTR=$(cat nmap/*Ext*.nmap | grep  -e "/tcp \+open" | tr -d '[a-zA-Z]/._:' | cut -d ' ' -f 1 )
TCPCOMMA=$(sort $TCPSTR | uniq | tr -s '\n' ', ')
TCPCOUNTINT=$(expr "$TCPCOUNTSTR" + 0)
TOTALCOUNT=$(($TCPCOUNTINT + 2))

INCR_FILENUM_STR_FOR_TCP_PORTS=$(for i in $(seq 2 $TOTALCOUNT); do echo $i"0"; done)
PORT_X_TCP_STR=$(echo "$TCPSTR" | awk '{print "-Port-"$1"-TCP"}')

# Convert each to an array X and Y  
#for i in $(seq 1 $TCPCOUNTINT); do echo "X-Y.md" ; done
# eg 20-Port-80-Notes.md


cp Notes/0-*-Notes.md Notes/10-$NAME-Nmap-sC-sV-Notes.md
echo '```bash' >> Notes/10-$NAME-Nmap-sC-sV-Notes.md
cat nmap/*Ext*.nmap >> Notes/10-$NAME-Nmap-sC-sV-Notes.md
echo '```' >> Notes/10-$NAME-Nmap-sC-sV-Notes.md
cp Notes/0-*-Notes.md Notes/11-$NAME-Nmap-Disc-Notes.md
echo '```bash' >> Notes/11-$NAME-Nmap-Disc-Notes.md
cat nmap/*Disc*.nmap >>  Notes/11-$NAME-Nmap-Disc-Notes.md
echo '```' >>  Notes/11-$NAME-Nmap-Disc-Notes.md
cp Notes/0-*-Notes.md Notes/12-$NAME-Nmap-Vuln-Notes.md
echo '```bash' >> Notes/12-$NAME-Nmap-Vuln-Notes.md
cat nmap/*Vuln*.nmap >> Notes/12-$NAME-Nmap-Vuln-Notes.md
echo '```' >> Notes/12-$NAME-Nmap-Vuln-Notes.md
# 13-14 is UDP SCANs do not use full and then sV sC for speed
# 15 onwards are rescans


echo '# $BOXNAME Privilege Escalation Profiling

## Profile Template

```
Username: 
Credentials:
Groups:
Access Control Privileges:
user-writable directories:
group-writable directories:
Service Control:
Crons/SchTasks of importance:
```
Commands for Context used:
```
```

' > Notes/Privilege-Escalation-Profile-Template.md

echo '# $BOXNAME Lateral Movement Profiling

## Profile Template

```
Username: 
Credentials:
Domains the account is enabled:
Localgroups:
Domain groups
Remote Access:
Machine control:
```
Commands for Context used:
```
```

' > Notes/Lateral-Movement-Profile-Template.md
