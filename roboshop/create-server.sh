#!/bin/bash

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro --key-name MyKeyPair

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=production}]' 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'

#aws ec2 describe-images  --owners amazon --filters "Name=platform,Values=windows" "Name=root-device-type,Values=ebs"

#aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'

#aws ec2 describe-security-groups --filters Name=ip-permission.from-port,Values=22 Name=ip-permission.to-port,Values=22

#aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g'

COMPONENT=$1
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')

echo -e "AMI ID is to launch ec2 instance \e[34m $AMI_ID\e[0m"
echo -e "security group to launch ec2 instance \e[31m $SG_ID\e[0m"
IP_ADD=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" |jq '.Instances[].PrivateIpAddress' | sed -e '/s/"//g')

echo -e "Private IP address to launch ec2 instance \e[34m $IP_ADD \e[0m"