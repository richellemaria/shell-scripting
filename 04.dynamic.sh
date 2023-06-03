#!/bin/bash

#Today_date="03062023"    #hardcoded
Today_date=$(date +%D)    #softcode expression always in paranthesis

echo -e "Today's date is \e[34m ${Today_date} \e[0m"