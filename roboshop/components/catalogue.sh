#!/bin/bash

COMPONENT=catalogue
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
  exit 2
fi
}

echo -n "configuring the repo"
curl curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
stat $?

echo -n "installing nodejs"
yum install nodejs -y &>> $LOGFILE
stat $?

echo -n "creating service account"
useradd roboshop
stat $?

