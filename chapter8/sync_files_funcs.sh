#!/bin/bash 
# If she bang line is not present. 

if [ $# -ne 2 ]; then
    echo "Usage: $0 [dir1] [dir2]" 1>&2 # to cllect it from 2. 
    exit 1 # should exit it. 
fi

directory1="$1"
directory2="$2"

if [ ! -w "$directory1" -o  ! -w "$directory2" ]; then
    echo "Usage: $0 Both $directory1 and $directory2 should exist and be writable or else shell variable CREATE_DIRECTORIES set to 0" 1>&2
    exit 1
fi

function sync_dir () {

dir1="$1"
dir2="$2"

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

}

sync_dir "$directory1" "$directory2"
sync_dir "$directory2" "$directory1"



