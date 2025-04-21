#!/usr/bin/env python3
# Script Name: list_ec2_instances.py
# Description: Lists all EC2 instances in the AWS account, displaying their ID, state, name, and public IP address.
# Author: Manny
# Date: 2025-04-10
# Version: 1.1
# Usage: python list_ec2_instances.py

import boto3
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def list_ec2_instances():
    ec2 = boto3.client('ec2')

    try:
        response = ec2.describe_instances()

        # Log header
        logging.info(f"{'Instance ID':<20} {'State':<15} {'Name':<30} {'Public IP':<20}")
        logging.info("-" * 90)

        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instance_id = instance.get('InstanceId', 'N/A')
                state = instance.get('State', {}).get('Name', 'N/A')
                public_ip = instance.get('PublicIpAddress', 'N/A')

                name = 'N/A'
                if 'Tags' in instance:
                    for tag in instance['Tags']:
                        if tag['Key'] == 'Name':
                            name = tag['Value']

                logging.info(f"{instance_id:<20} {state:<15} {name:<30} {public_ip:<20}")

    except Exception as e:
        logging.error(f"Error fetching EC2 instances: {e}")

if __name__ == "__main__":
    list_ec2_instances()
    