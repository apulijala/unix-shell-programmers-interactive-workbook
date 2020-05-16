#!/bin/bash 


if [ $# -ne 1 ] 
then 
    echo "Usage: $0  item" 1>&2
    exit 1
fi

item="$1"

if [ -f "$item" ]
then 
    echo "$item is a file"
elif [ -d "$item" ]
then
    echo "$item is a directory"
else 
    echo "$item is unknown"
fi 
