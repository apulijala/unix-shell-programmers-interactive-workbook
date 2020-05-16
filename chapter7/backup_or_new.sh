#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 dir file" 1>&2   
    exit 1
fi
dir="$1"
file="$2"
if [ ! -d "$dir" -o ! -w "$dir" ]; then
    echo "$dir must be a directory andc writable" 1>&2
    exit 1
fi

if [ -f "$dir/$file" ]; then
     cp "$dir/$file" "$dir/$file.bk"
else
     touch "$dir/$file"
fi
