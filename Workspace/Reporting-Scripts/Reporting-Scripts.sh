#!/bin/bash


cat Notes/$NAME-Notes.md | grep '.png' | awk '{print "![]("$1")\n"}' | xsel -b
