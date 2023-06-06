#!/bin/bash

COMPONENT=frontend
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

echo -n "installing nginx"
yum install nginx -y &>> /${LOGFILE}
stat $?

echo -n "downloading the ${COMPONENT} component"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>> ${LOGFILE}
stat $?

echo -n "Extracting the ${COMPONENT} component"
unzip /tmp/${COMPONENT}.zip &>> ${LOGFILE}
mv ${COMPONENT}-main/* . 
mv static/* . 
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf 
stat $?

echo -n "starting ${COMPONENT} service"
systemctl enable nginx &>> ${LOGFILE}
systemctl start nginx &>> ${LOGFILE}
stat $?
