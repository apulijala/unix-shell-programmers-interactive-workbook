#!/bin/bash
# 13:12 start programming. 

#!/bin/bash

ls -laRt .> /tmp/file.txt

exec 3< "/tmp/file.txt"

filesize=0
dir="."
count=0

while read -u3 line 
do  
    if [[ $line =~ :$ ]]
    then
        # echo $line
        # echo the file size. 
        if [ $count -ne 0 ] 
        then
            echo -e "$filesize\t$dir"
            dir=$line
            ((filesize=0))
        fi
        

    elif [[ $line =~ ^- ]]
    then 
        # echo "$line"
        IFS=' ' read -ra tokens <<< "$line"
        read -ar tokens <<< "$line"
        ((filesize += ${tokens[4]}))
        ((count++))
        # echo "token 5 is ${tokens[4]}"
    fi
    
    # echo "line is $line"
done
echo -e "$filesize\t$dir"