#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-"
INSTANCES=("mongodb" "redis" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="ZO"
DOMAIN_NAME="karna.fun"

for instance in ${INSTANCES[@]}; do
    INSTANCE-ID=$(aws ec2 run-instances --image-id ami-09 --instance-type t2.micro --security-group-ids sg-01 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "InstanceId" --output text)
    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address: $IP"
done
