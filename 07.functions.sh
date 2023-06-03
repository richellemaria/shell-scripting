#!/bin/sh

#declare a function

sample(){

    echo "I am sample function with name sample"
    echo "I am executing sample function"
}

#calling sample function

sample
status

#declare status function

status(){
    echo "Today's date is $(date +%F)"
    echo "Number of process running $(who | wc -l)"
}

#calling status function
status