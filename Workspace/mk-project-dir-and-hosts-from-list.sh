#!/bin/bash

if [ "$#" -eq 2 ]; then
	echo "Usage: $0 <parent directory name> <Initial CIDR Range of network>"
	exit
fi

mkdir $1
echo "# $1 General Notes
CIDR: $2
Subnets:
External:
Interal:
Domain name:
Network Purpose:
Email Address & Formatting:
Username Format:
##Scope
Do Not!
- X
##Objectives
#### What do have in the solutions inventory to meet larger objective?

####Credentials and Hashes
####HUMINT
####Todo List
#### Timeline of tasks completed" > $1/$1-General-Notes.md
exit
