#!/bin/bash

Action=$1
case $Action in
    start)
        echo "starting server"
        ;;
    stop)
        echo "stopping server"
        ;;
    *)
        echo " you can either start or stop"
        ;;

esac