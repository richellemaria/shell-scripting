#!/bin/bash

action=$1
if [ "$action" == "start" ] ; then
   echo -e "\e[34m starting server \e[0m"
   exit 0
elif [ "$action" == "stop" ] ; then
    echo -e "\e[32m stopping server \e[0m"
    exit 1
elif [ "$action" == "restart" ] ; then
    echo -e "\e[31m restarting server \e[0m"
    exit 2
else 
    echo -e "file executed $0"
    exit 3

fi