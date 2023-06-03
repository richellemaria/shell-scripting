#!/bin/bash

#special variables gives special properties to your variable

echo $0    #prints script name you executing

echo "Name of script executing is $0"
echo "My name is is $1"
echo "I am studying $2"


echo $*
echo $@
echo $$
echo $#
echo $?