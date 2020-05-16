function l () {
    ls "$@" | more
}


function l_modified () {
    if [ ! -z "$LSFLAGS" ]; then
        ls -"$LSFLAGS" "$@" | more
    else 
        ls "$@" | more
    fi
    
    
}

# For the second part. 
# export RMFLAGS='-i"
# alias rm='rm $LSFLAGS $@'


