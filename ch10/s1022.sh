#!/bin/bash
# s1022 -- Verify access to reports
# Usage : s1022 [report_name]
# Where the report_name is the anme of the tex file to start or continue 
# editing . The user may not start a new report until a previous one 
# has been completed. 

# Check the current report name supplied by the user, if there is one. 

current_report=$(cat ~/.s1022_current_report 2>/dev/null)

case $# in 

0) [[ "$current_report"  == "" ]] && {
        echo "You must give the name of a new report to start editing"
        exit 1
}

;;
1) [[ "$current_report"  != ""  && $current_report != "$1" ]] && {

    cat  <<EOF  1>&2
    You are already working on "$current_report", so you may not 
    start a report named "$1".
    If this is not correct, remove the file ~/.s1022_current_report. 
EOF
    
    exit 1

}

echo  "$1" >| ~/.s1022_current_report
;;

*) 
    echo "Usage: s1022 [report name]"
    exit 1
;;
esac

vi  -- "$(cat ~/.s1022_current_report)" 



