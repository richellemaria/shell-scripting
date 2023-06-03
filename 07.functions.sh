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
    echo "Today's date is $(date +%F)"
    echo  -e "Number of process running \e[34m $who | wc -l \e[0m"
}

#calling status function
status