#!/bin/bash
# 13:12 start programming. 

function summarizeDir() {

        echo "$1"
        num="$2"
        tmpfile="/tmp/result_$num.txt"
        dir="$1"
        
        echo "Directory and number are $dir $num"
        ls -l "$dir" > "$tmpfile"
        filesize=0
#        echo "Filesize in recursive callses $filesize"
        exec 3<"$tmpfile"
        filesanddirs=()
        IFS=+
        while read -u3 line 
        do 
            filesanddirs=( "${filesanddirs[@]}" "$line")
        done

        for line in ${filesanddirs[@]}
        do 
            IFS=" "
            if [[ $line =~ ^-.* ]]
            then
                IFS=' ' read -ra tokens <<< "$line"
              #  echo "$line"
                ((filesize+=${tokens[4]}))  
              #  echo "token is ${tokens[4]}"
            elif [[ $line =~ ^d.* ]]
            then
                IFS=' ' read -ra tokens <<< "$line"
                olddir="/tmp/dir_$num.txt"
                echo "saving $dir to a temp file $olddir"
                echo "$dir" > $olddir
                ((num++))
                echo "Number before recursion is $num"
                echo "Directory before recursion is $dir"
                summarizeDir "$dir/${tokens[8]}" $num
                dir=$(cat $olddir)
                ((num--))
                
                echo "Number after recursion is $num"
                echo "Directory before recursion is $dir"
            fi
        done
        

}

summarizeDir .  1