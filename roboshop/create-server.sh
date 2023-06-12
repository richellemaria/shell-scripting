#!/bin/bash

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro --key-name MyKeyPair

#aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=production}]' 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'

#aws ec2 describe-images  --owners amazon --filters "Name=platform,Values=windows" "Name=root-device-type,Values=ebs"

#aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'

#aws ec2 describe-security-groups --filters Name=ip-permission.from-port,Values=22 Name=ip-permission.to-port,Values=22

#aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g'

COMPONENT=$1
ENV=$2
HostedZoneID="Z00601192FWSDGPTTWP2N"

if [ -z  $COMPONENT ] || [ -z $ENV ]  ; then
   echo -e "\e[34m pass the component name \e[0m"
   echo -e "\e[32m pass sh create-server.sh compenentName and environment \e[0m"
   exit 1

fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')

create_ec2(){
    echo -e "AMI ID is to launch ec2 instance \e[34m $AMI_ID\e[0m"
    echo -e "security group to launch ec2 instance \e[31m $SG_ID\e[0m"
    IP_ADD=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT-$ENV}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    echo -e "Private IP address to launch ec2 instance \e[34m $IP_ADD \e[0m"

    echo " launching $COMPONENT-$ENV server is completed"

    echo -e "creating dns record $COMPONENT"
    sed -e "s/COMPONENT/${COMPONENT}-${ENV}/"  -e "s/IPADD/${IP_ADD}/" route53.json  >  /tmp/roboshop.json
    aws route53 change-resource-record-sets --hosted-zone-id ${HostedZoneID} --change-batch file:///tmp/roboshop.json

    echo -e "\e[36m **** Creating DNS Record for the $COMPONENT has completed **** \e[0m \n\n"
}

if [ $1 = "all" ]; then
    for component in frontend mongodb catalogue redis user cart shipping mysql rabbitmq payment; do
        COMPONENT=$component
        create_ec2
    done
else
    create_ec2
fi
