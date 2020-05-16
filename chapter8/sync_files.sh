#!/bin/bash 
# If she bang line is not present. 

if [ $# -ne 2 ]; then
    echo "Usage: $0 [dir1] [dir2]" 1>&2 # to cllect it from 2. 
    exit 1 # should exit it. 
fi

dir1="$1"
dir2="$2"

if [ ! -w "$dir1" -o  ! -w "$dir2" ]; then
    echo "Both $dir1 and $dir2 should exist and be writable " 1>&2
    exit 1
fi

for file in "$dir1"/*
do 
    # echo "file is $file"
    # echo "file is ${file##*/}"
    if [ -f "$file" ]; then
        if [  -e "$dir2/${file##*/}" ]; then
           # echo "$file exists in $dir2"
            dir1date=$(date +%s -r "$file")
            dir2date=$(date +%s -r "$dir2/${file##*/}")

            if [ $dir2date -lt $dir1date  ]; then
                 cp "$file" "$dir2/${file##*/}"
            else
                 cp  "$dir2/${file##*/}" "$file"
            fi
        else
            cp "$file" "$dir2/${file##*/}"
        fi
    fi
done 



for file in "$dir2"/*
do 
    if [ -f "$file" ]; then
        if [  -e "$dir1/${file##*/}" ]; then
             # echo "$file exists in $dir2"
            dir2date=$(date +%s -r "$file")
            dir1date=$(date +%s -r "$dir1/${file##*/}")

            if [ $dir1date -lt $dir2date  ]; then
                 cp "$file" "$dir1/${file##*/}"
            elif [ $dir1date -eq $dir2date  ]; then
                echo "Both files are same"
            else
                 cp  "$dir1/${file##*/}" "$file"
            fi
        else
            cp "$file" "$dir1/${file##*/}"
        fi
    fi
done 



