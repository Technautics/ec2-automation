#!/bin/bash

set -e # Exit immediately if any command fails

echo "🚀 AWS Automation Started...."

# Check Internet Connectivity
echo "🌐 Checking Internet Connectivity..."
if ! ping -c 1 google.com &> /dev/null; then
	echo "❌ No Internet Connection. Exiting...."
	exit 1
fi
echo "✅ Internet is Working...."

# Check/Install AWS-CLI
echo "🔍 Checking AWS-CLI...."

if ! command -v aws &> /dev/null; then
	echo "⚙️ AWS not found. Installing..."

	sudo apt update
	sudo apt install -y unzip curl

	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	echo "AWS-CLI Installed🎉"
else
	echo "AWS-CLI already configured✅"
fi

# Variables
AMI_ID="ami-0ec10929233384c7f"
INSTANCE_TYPE="t3.micro"
KEY_NAME="admin-md-2005"
SECURITY_GROUP="default"

# Launch an EC2 Instance
echo "Launching an EC2 Instance🚀....."

INSTANCE_ID=$(aws ec2 run-instances \
	--image-id $AMI_ID \
	--instance-type $INSTANCE_TYPE \
	--key-name $KEY_NAME \
	--security-groups $SECURITY_GROUP \
	--query 'Instances[0].InstanceId' \
	--output text)

echo "✅ Instance Launched : $INSTANCE_ID"

# Wait until instance is running
echo "⏳ Wait until Instance to be running...."

aws ec2 wait instance-running --instance-ids $INSTANCE_ID

echo "✅ Instance is now running...."

echo "🌍 Fetching instance details..."

PUBLIC_IP=$(aws ec2 describe-instances \
	--instance-ids $INSTANCE_ID \
	--query 'Reservations[0].Instances[0].PublicIpAddress' \
	--output text)

STATE=$(aws ec2 describe-instances \
	--instance-ids $INSTANCE_ID \
	--query 'Reservations[0].Instances[0].State.Name' \
	--output text)

# Output:-

echo "🎉 EC2 INSTANCE READY....."
echo "---------------------------"
echo "Instance ID : $INSTANCE_ID"
echo "Public IP : $PUBLIC_IP"
echo "State : $STATE"
echo "---------------------------"




