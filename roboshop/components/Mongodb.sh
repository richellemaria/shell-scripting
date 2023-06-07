#!/bin/bash

COMPONENT=mongodb
LOGFILE=/tmp/${COMPONENT}.log
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

echo -n "configuring the repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "installing $COMPONENT"
yum install -y $COMPONENT-org &>> $LOGFILE
stat $?

echo -n "starting $COMPONENT"
systemctl enable mongod  &>> $LOGFILE
systemctl start mongod   &>> $LOGFILE
stat $?