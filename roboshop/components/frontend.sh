#!/bin/bash

COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ]; then
   echo -e "\e[31m This should be run as root or sudo previlige \e[0m"
   exit 1
fi

stat(){
    if [ $1 -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else 
  echo -e "\e[31m failure \e[0m"
fi
}

echo -n "installing nginx"
yum install nginx -y &>> "/tmp/${COMPONENT}.log"
stat $?

echo -n "downloading the ${COMPONENT} component"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>> "/tmp/${COMPONENT}.log"

stat $?