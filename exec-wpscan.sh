#!/bin/bash

if [ "$#" -ne  ]; then
	echo "Usage: $0 'http://URLgoesHere' 'APIKey'"
	echo "The script will update wpscan prior to running beware"
	echo "This is not a stealth method. Consider running --h for customised options!"
	exit
fi

initVersion=$(wpscan --version | grep Current | awk '{print $3}')
wpscan --update
wait
postUPDVersion=$(wpscan --version | grep Current | awk '{print $3}')
echo ""
url=$1
APIKEY=$2
dash_delimited_url=$(echo $1 | awk -F/ '{print $3}' | tr -s '.' '-')
wpscan --url $url -e --rua --api-token $APIKEY -o $dash_delimited_url.wpscan
wait
echo "Previous Version: $initVersion"
echo "Post update version if requried: $postUPDVersion"
echo ""
exit
