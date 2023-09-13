#!/bin/bash

cidr=$1
interface=$2
portScanRate=$3

dash_delimited_network_range=$(echo $1 | tr -s '.' '-' | sed 's#/#-cidr-#g')
mkdir -p Network-$dash_delimited_network_range/{nmap,masscan,data,credentials,server}
mkdir -p Network-$dash_delimited_network_range/server/{www,smb,tools,ftp}
echo "# $cidr - General Notes
CIDR: $cidr
Subnets:
- External:
- Interal:
Domain name:
Network Purpose:
Email Address & Formatting:
Username Format:

\`\`\`bash
sed -i 's/\$oldip/\$newip/g' *-CMD-by-CMDs.md

ls -1 Screenshots | awk '{print"![]("\$1")"}'
\`\`\`

## Objectives
What do have in the solutions inventory to meet larger objective?

## Scope
- **Do Not!**
	- X

	
#### Credentials and Hashes
\`\`\`

\`\`\`

\`\`\`

\`\`\`

#### Intel

#### Todo List


#### Timeline of tasks completed

" > Network-$dash_delimited_network_range/$dash_delimited_network_range-Notes.md

$AR_EXEC="AutomateRecon/exec"
$AR_DEXT="AutomateRecon/Data-Extraction/extract-"
$AR_WORK="AutomateRecon/Workspace"

$SHELL -c "$AR_EXEC-masscan-cidr.sh $cidr $interface $portScanRate"
wait
$SHELL -c "$AR_DEXT-masscan-hosts-up.sh $cidr"
wait
$SHELL -c "$AR_EXEC-masscan-allports-list.sh hosts.txt $interface $portScanRate"
wait
$SHELL -c "$AR_WORK/mk-hosts-dir-from-list.sh hosts.txt"

hosts=$(cat hosts.txt) 
for host in $hosts; do 
	$SHELL -c "$AR_EXEC-nmap-sc-sv-plus-discNvuln-someports.sh $host $interface $portScanRate"
	wait
	$SHELL -c "$AR_WORK/mk-hosts-dir-from-list.sh hosts.txt"
done
