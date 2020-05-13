trap 'read -u3; read -u4; echo -e "\nProgram Interrupted"; exit 1' 2

while read -p "Name two files that you want to shuffle: ? " -a inFiles
do  
    # exit from the script if you have to . 

    [[ ${inFiles[0]} == "." || ${inFiles[0]} == "q" ]] && break 
    # No two files
    [[ ${#inFiles[@]} != 2 ]] && {
        echo "Enter two file names. Use quotes if necessary. " 1>&2
        continue
    }

    [[ ! -r ${inFiles[0]} || ! -r ${inFiles[1]}   ]] && {
        echo "${inFiles[0]} and ${inFiles[1]} must both exist and be readable " 1>&2
        continue
    }

exec 3< "${inFiles[0]}"
exec 4< "${inFiles[1]}"

read -p "Where do you want the shuffled ouptut? " outFile 
overwrite=1
newfile=0

if [ -f "$outFile" ] 
then
    newfile=1
    read -p "$outFile exists. Do you want to overwrite (y/n)? "  answer
    if [[ $answer == "y"  || $answer == "Y" ]]  
    then 
            overwrite=0
    fi
fi

exec 5> "$outFile"
IFS= 
    while read -u3
    do 
        if [[ "$newfile" == 0 || "$overwrite" == 0   ]] 
        then 
            echo "$REPLY" >> "$outFile"
        else # send to screen
            echo "$REPLY" 
        fi
        
        read -u4 
        if [[ "$newfile" == 0 || "$overwrite" == 0 ]] 
        then 
            echo "$REPLY" >> "$outFile"
        else # send to screen
            echo "$REPLY" 
        fi
    done
# Now the debugger. 
 while read -u4
    do 
        if [[ "$newfile" == 0 || "$overwrite" == 0 ]] 
        then 
            echo "$REPLY" >> "$outFile"
        else # send to screen
            echo "$REPLY" 
        fi
    done

IFS='  \t\n'
exec 3<&-
exec 4<&-
exec 5<&-
done
echo