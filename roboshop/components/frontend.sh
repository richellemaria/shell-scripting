#!/bin/bash

COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ]; then
   echo -e "\e[31m This should be run as root or sudo previlige \e[0m"
   exit 1
fi

echo -n "installing nginx"
yum install nginx -y &>> "/tmp/${COMPONENT}.log"
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else 
  echo -e "\e[31m failure \e[0m"
fi

echo -n "downloading the frontend component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else 
  echo -e "\e[31m failure \e[0m"
fi

echo -n "performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>> "/tmp/"${COMPONENT}.log"

if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else 
  echo -e "\e[31m failure \e[0m"
fi