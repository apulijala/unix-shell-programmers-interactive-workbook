#!/bin/bash 
# time ./echo_built_in.sh 
# real	0m0.011s
# user	0m0.012s
# sys	0m0.000s

# time ./echo_with_external.sh
# real	0m0.134s
# user	0m0.099s
# sys	0m0.044s
# Buit in is faster than external by 12.18.18 times.

for i in $(seq 1 100)
do 
    /bin/echo "$i is it good, where is the echo"
done