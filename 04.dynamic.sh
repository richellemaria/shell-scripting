#!/bin/bash

#Today_date="03062023"    #hardcoded
Today_date=${date +%D}

echo -e "Today's date is \e[34m $(Today_date) \e[0m"