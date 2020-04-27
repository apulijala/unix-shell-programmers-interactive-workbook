if [ $# -ne 1 ]; then
     echo "Usage: $0 <monthsfile>"
     exit 1
fi


cat "$1" |  while read month 
do 
    echo "$month" | tr '[A-Z]' '[a-z]' | cut -c1-3 >> mons
done