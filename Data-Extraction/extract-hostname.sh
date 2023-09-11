#!/bin/bash

grep -r */nmap/*.nmap -e 'Name:'
echo "You may need to make note of these.."
