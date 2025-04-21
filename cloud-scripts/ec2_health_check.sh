#!/bin/bash
# Script Name: ec2_health_check.sh
# Description: Pings an EC2 instance's Public IP to check if it is reachable.
# Author: Manny
# Date: 2025-04-20
# Version: 1.0
# Usage: bash ec2_health_check.sh <EC2_PUBLIC_IP>

# Check if IP argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <EC2_PUBLIC_IP>"
  exit 1
fi

EC2_IP="$1"

echo "Pinging EC2 instance at $EC2_IP..."
echo

# Ping the instance (send 3 packets)
ping -c 3 "$EC2_IP" > /dev/null 2>&1

# Check if ping was successful
if [ $? -eq 0 ]; then
  echo "✅ Instance $EC2_IP is reachable!"
else
  echo "❌ Instance $EC2_IP is NOT reachable."
fi
