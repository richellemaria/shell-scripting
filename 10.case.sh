#!/bin/bash

Action=$1
case $Action in
    start)
        echo -e "\e[34m starting server \e[0m"
        exit 0
        ;;
    stop)
        echo -e "\e[32m stopping server \e[0m"
        exit 1
        ;;
    *)
        echo -e "\e[31m you can either start or stop \e[0m"
        exit 2
        ;;

esac