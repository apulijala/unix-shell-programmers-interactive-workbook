#!/bin/bash 

num1="$1"
num2="$2"

# Function need to be defined first
sin ()
{
    echo "scale=5;s($1)" | bc -l
}

cos ()
{
    echo "scale=5;c($1)" | bc -l
}

tan ()
{
    echo "scale=5;s($1)/c($1)" | bc -l
}

sqrt() {
    echo "scale=4;sqrt($1)" | bc -l

}

if [ $# -lt 1 -o   $# -gt 2 ]; then
    echo "Usage: $0 num1 [num2]" 1>&2
    exit 1
fi


PS3="Select Operation:  "
if [ $# -eq 2 ]; then
    select op in "add" "subtract" "mulitply" "divide" "quit"
    do 
    case $op in 
    "add") 
            echo $((num1 + num2))
        ;;
    "subtract") 
            echo $((num1 - num2))
        ;;
    "multiply") 
            echo $((num1 * num2))
        ;;
    "divide") 
            echo $((num1 / num2))
        ;;
    "quit")
            exit 0
    esac
    done
fi    
 [ $# -eq 1 ] && { 
    select op in "sin" "cos" "tan" "sqrt" "quit"
    do 
        case $op in 
        "sin") 
                sin "$num1"
            ;;
        "cos") 
                cos "$num1"
            ;;
        "tan") 
                tan "$num1"
            ;;
        "sqrt") 
                sqrt "$num1"
            ;;
        "quit")
            exit 0
        esac
    done
 }

