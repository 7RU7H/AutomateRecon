

AutomateRecon/exec-masscan-cidr.sh 10.10.10.0/24 tun0 1000
AutomateRecon/exec-masscan-allports-list.sh hosts.txt tun0 1000
AutomateRecon/Workspace/mk-hosts-dir-from-list.sh hosts.txt

hosts=$(cat hosts.txt) 
for host in $hosts; do 
	AutomateRecon/exec-nmap-sc-sv-plus-discNvuln-someports.sh $host tun0 1000
done
