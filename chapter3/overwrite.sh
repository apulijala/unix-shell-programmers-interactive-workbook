function overwrite() {

    # Debugger is picking some other context.
    # 15:31 start
    # To run line by line use Step Over (F8) arrow and dot.
    # To run to next breakpoint use F5 (Continue)
    # To step into (For example inside a function) use
    # down arrow with a dot . 
    # To step out use Shift + F11 

    if [ $# -ne 2 ]; then
        for i in $@
        do 
            echo "$i"
        done
        echo "Usage: overwrite file1 file2" 1>&2 # so that those who 
                                                 # want to caputure 
                                                 # output can capture it 
                                                 # correctly.
        exit 1
    fi
    cp "$1" "$2"    
}

#Answer to scripting exercise.
# c is I can verify using set -o and noclobber is offf
# to confirm more I can create a file . and try to overwrite it.
# echo "Rama" >> file_c
# any environment, shell variable, shell option changes in function 
# take effect in current shell. where as with script it won't because
# it will be done by child shell.
# d . > will prevent overwriting of the existing files. 
# User can be warned and confirmed for overwrite. 

function overwrite_with_noclobber() {

    if [ $# -ne 2 ]; then
        echo "Usage: overwrite file1 file2" 1>&2 # so that those who 
                                                 # want to caputure 
                                                 # output can capture it 
                                                 # correctly.
        exit 1
    fi
    set -o xtrace
    cat < "$1" > "$2"
    status="$?"
    if [ "$status" -ne 0 ]; then
        # body remove the noclobber setting. 
        # set -o noclobber # error should not be -o
        set +o noclobber
        cat < "$1" > "$2" 
    fi
    # 19500
}

# Invoking the function this way is creating a new shell process

# overwrite "/home/arvind/unix-shell-programmers-interactive-workbook/chapter3/file_a" "/home/arvind/unix-shell-programmers-interactive-workbook/chapter3/file_b" 
# overwrite_with_noclobber "/home/arvind/unix-shell-programmers-interactive-workbook/chapter3/file_a" "/home/arvind/unix-shell-programmers-interactive-workbook/chapter3/file_b" 