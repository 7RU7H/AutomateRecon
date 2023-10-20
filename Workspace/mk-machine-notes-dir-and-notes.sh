#!/bin/bash

CWD=$(pwd)
mkdir $CWD/Notes
touch $CWD/Notes/0.md
echo "# $CWD General Notes

## Data

IP:
OS:
Arch:
Hostname:
DNS:
Domain:  / Domain SID:
Machine Purpose:
Services:
Service Languages:
Users:
Email and Username Formatting:
Credentials:

## Objectives

\`\#\# Target Map ![]($CWD-map.excalidraw.md)\`

#### Machine Connects to list and reason:

[[]] - Reason X

## Data Collected

#### Credentials
\`\`\`
\`\`\`

#### HUMINT


#### Solution Inventory Map


#### Todo


#### Timeline of tasks complete

" > $CWD/Notes/General--Notes.md
exit
