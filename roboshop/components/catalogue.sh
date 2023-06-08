#!/bin/bash

COMPONENT=catalogue
LOGFILE=/tmp/${COMPONENT}.log
Appuser=roboshop

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

id $Appuser &>> $LOGFILE
if [ $? -ne 0 ] ; then
   echo -n "creating service account"
   useradd $Appuser &>> $LOGFILE
   stat $?
fi

echo -n "downloding the $COMPONENT component"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "copying the $COMPONENT to $Appuser home directory"
cd /home/$Appuser
rm -f $COMPONENT &>> $LOGFILE
unzip -o /tmp/$COMPONENT.zip &>> $LOGFILE
stat $?

echo -n "modifying the ownership"
mv $COMPONENT-main/ $COMPONENT
chown -R $Appuser:$Appuser /home/$Appuser/$COMPONENT
stat $?

echo -n "generating npm $COMPONENT artifact"
cd /home/$Appuser/$COMPONENT
npm install &>> $LOGFILE
stat $?


