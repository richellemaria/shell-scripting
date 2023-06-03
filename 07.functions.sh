#!/bin/sh

#declare a function

sample(){

    echo "I am sample function with name sample"
    echo "I am executing sample function"
}

#calling sample function

sample

#declare status function

status(){
    no_user=$(who | wc -l)
    echo "Today's date is $(date +%F)"
    echo  -e "Number of user running \e[32m $no_user \e[0m"
}

#calling status function
status