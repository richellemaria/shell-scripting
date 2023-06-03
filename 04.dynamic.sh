#!/bin/bash

#Today_date="03062023"    #hardcoded
Today_date=$(date +%D)    #softcode expression always in paranthesis
No_user=$(who | wc -l)    #who shows no of session or user logged in

echo -e "Today's date is \e[34m ${Today_date} \e[0m"
echo -e "The no of user are \e[32m ${No_user} \e[0m"