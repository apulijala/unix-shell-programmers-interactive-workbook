#!/bin/bash 
# If she bang line is not present. 
# How the multiple command line options can be got. 
# How command line can be used witha arguments. 

echo $# 
if [ $# -ne 2 -a $# -ne 3 ]; then
    echo "Usage: $0 [c] dir1 dir2" 1>&2 # to cllect it from 2. 
    exit 1 # should exit it. 
fi
overwrite=1
if [ $# -eq 3 ]; then 
    overwrite=0
    shift # to remove the argument. 
fi

directory1="$1"
directory2="$2"

if [ ! -w "$directory1" -o  ! -w "$directory2" ]; then
    # echo "create dirs is $CREATE_DIRECTORIES"
    if [ -w "$directory1" -a "$CREATE_DIRECTORIES" -eq 0 ]; then
        mkdir -p "$directory2"
    elif [ -w "$directory2" -a "$CREATE_DIRECTORIES" -eq 0 ]; then
        mkdir -p "$directory1"
    else 
        echo "Usage: $0 Both $directory1 and \
$directory2 should exist and be writable or  \
else shell variable CREATE_DIRECTORIES set to 0 and one \
of the directories should exist." 1>&2
        exit 1
    fi
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
                if [ "$overwrite" -eq 0 ]; then 
                    PS3="Overwrite $file? "
                    select input in yes no 
                    do 
                        case "$input" in 
                            yes)
                                if [ $dir2date -lt $dir1date  ]; then
                                    cp "$file" "$dir2/${file##*/}"
                                else
                                    cp  "$dir2/${file##*/}" "$file"
                                fi
                            break
                        ;;
                        no) 
                                break
                        ;;

                        esac
                    done
                
                else
                    if [ $dir2date -lt $dir1date  ]; then
                        cp "$file" "$dir2/${file##*/}"
                    else
                        cp  "$dir2/${file##*/}" "$file"
                    fi
        
                fi

                
            else
                cp "$file" "$dir2/${file##*/}"
            fi
        fi
    done 

}

sync_dir "$directory1" "$directory2"
sync_dir "$directory2" "$directory1"



