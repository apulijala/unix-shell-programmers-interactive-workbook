#!/bin/bash
# s1022 -- Verify access to reports
# Usage : s1022 [report_name]
# Where the report_name is the anme of the tex file to start or continue 
# editing . The user may not start a new report until a previous one 
# has been completed. 
# Check the current report name supplied by the user, if there is one. 
current_report=$(cat ~/.s1022_current_report 2>/dev/null)

function s1022_initialize() {

    read -p "Enter the Archive directory: "  archivedir
    echo "Archive directory is $archivedir"
    ARCHIVE_DIR=$archivedir

    if [ ! -d "$ARCHIVE_DIR" ]; then
        echo "$ARCHIVE_DIR does not exist " 1>&2
        exit 1
    fi
}


function err_message() {
   
    current_report="$1"
    cat  <<EOF  1>&2
    You are already working on "$current_report", so you may not 
    start a report named "$1".
    If this is not correct, remove the file ~/.s1022_current_report. 
EOF
}

function s1022_finish() {

    email="$1"
    file="$2"
    local current_report="$3"

    if [ ! -z "$email" ]; then
         cat $file
    fi
    # Archive the file  
  
    if [  -z "$ARCHIVE_DIR" ]; then
        echo "ARCHIVE_DIR doesnot exist " 1>&2
        exit 1
    fi
    
    err=$(mv "$file" "$ARCHIVE_DIR")
    status=$?

    if [ "$status" -eq 0 ]
    then   
        echo "$file moved to $ARCHIVE_DIR"
        rm -f "$current_report"
    else 
        echo -e "Could not archive the file $file successfully .\n $err" 1>&2
        exit 1
    fi 

}

function validate_file() {
    
    file="$1"
    dir=${file%/*}
    if [ "$file" = "$dir" ]
    then 
        dir="."
    fi
   
    if [ -e "$file" ] 
    then
        if [ ! -r "$file" -o  ! -w "$file" ]
        then
            echo "$file is not readable or writable " 1>&2
            exit 1
        fi
    else 
        if [ ! -w "$dir" ] 
        then 
            echo "$dir is not writable " 1>&2
            exit 1
        fi
    fi
}


s1022_initialize

case $# in 

0) [[ "$current_report"  == "" ]] && {
        echo "You must give the name of a new report to start editing" 1>&2
        exit 1
}
file="$current_report"
;;

1) 
file="$1"
[[ "$current_report"  != ""  && $current_report != "$1" ]] && {
        err_message "$current_report"
    exit 1
}

validate_file "$1"

echo  "$1" >| ~/.s1022_current_report
;;

2) 
file="$1"
[[ "$current_report"  != ""  && $current_report != "$1" ]] && {
        err_message "$current_report"
    exit 1
}

email="$2"

;;

*) 
    echo "Usage: s1022 [report name]"
    exit 1
;;
esac
REPORT_EDITOR=""
PS3="Select the editor to edit the file with "
select editor in vi emacs
do 
    if [ "$REPLY"  -le 0 -o "$REPLY" -gt 2 ]
    then 
        echo "Choice $REPLY is not a valid choice. Please select a valid one"
        continue
    else 
        REPORT_EDITOR=$editor
        break
    fi
done


# Directory pattern is 
eval $REPORT_EDITOR  -- "$(cat ~/.s1022_current_report)" 
s1022_finish "$email" "$file" "$current_report"