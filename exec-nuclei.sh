#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <full url including protocol> <project directory>"
	exit
fi

dash_delimited_naming=$(echo $1 | tr -s '.' '-')

nuclei -me $2/nuclei-$dash_delimited_naming -u $1
wait
exit



