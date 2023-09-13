#!/bin/bash

if [ "$#" -eq 1 ]; then
        echo "Usage: $0 <directory name>"
        exit
fi

echo "# $1-Notes

## Data 

IP: 
OS:
Hostname:
Domain:  / Domain SID:
Machine Purpose: 
Services:
Service Languages:
Users:
Credentials:
" > $1/$1-Notes.md
