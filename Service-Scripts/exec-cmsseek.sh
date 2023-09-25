#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <url> UNDERCONSIDERATION: <y/n for follow redirects>"
	exit
fi

followFlag="--follow-redirects "
dontfollowFlag="--no-redirect "
lightscanFlag="--light-scan "

echo "Under consider $follow, $dontfollowFlag, $lightscanFlag"

dash_delimited_naming=$(echo $1 | tr -s '.:/' '-')
CWD=$(pwd)
cmsseek -o -r -u $1 | tee -a $CWD/CMSseek/$dash_delimited_naming
wait
exit
