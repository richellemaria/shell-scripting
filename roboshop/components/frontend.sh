#!/bin/bash

COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ]; then
   echo -e "\e[31m This should be run as root or sudo previlige \e[0m"
   exit 1
fi

echo "installing nginx"
yum install nginx -y &>> "/tmp/${COMPONENT}.log"