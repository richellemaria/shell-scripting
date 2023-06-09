#!/bin/bash

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro --key-name MyKeyPair

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro

#aws ec2 describe-images  --owners amazon --filters "Name=platform,Values=windows" "Name=root-device-type,Values=ebs"

#aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo -e "AMI ID is to launch ec2 instance \e[34m $AMI_ID\e[0m"

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro