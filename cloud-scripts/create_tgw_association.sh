#!/bin/bash

# Script Name: create_tgw_association.sh
# Description: Creates a TGW attachment and associates it with a route table.
# Author: Manny
# Date: 2025-04-10
# Version: 1.0
# Usage: ./create_tgw_association.sh


TGW_RT_ID="" # Transit Gateway Route Table ID
DRY_RUN=false  # Set to false to apply changes
aws sts get-caller-identity --output text --query Account

# Get attachment IDs
TGW_ATTACHMENTS=$(aws ec2 describe-transit-gateway-attachments \
  --filters "Name=tag:Name,Values=" \ # Add your filter here - tgw-attachment-name
  --query "TransitGatewayAttachments[*].TransitGatewayAttachmentId" \
  --output text \
  --region us-east-1)

# Loop through IDs
for ATTACH_ID in $TGW_ATTACHMENTS; do
  echo "Processing attachment: $ATTACH_ID"
  # Check if already propagating
  IS_ALREADY_PROPAGATING=$(aws ec2 get-transit-gateway-route-table-propagations \
    --transit-gateway-route-table-id "$TGW_RT_ID" \
    --query "TransitGatewayRouteTablePropagations[?TransitGatewayAttachmentId=='$ATTACH_ID']" \
    --output text \
    --region us-east-1)

  if [[ -z "$IS_ALREADY_PROPAGATING" ]]; then
    echo "Propagating: $ATTACH_ID"
    if [ "$DRY_RUN" = true ]; then
      aws ec2 enable-transit-gateway-route-table-propagation \
        --transit-gateway-route-table-id "$TGW_RT_ID" \
        --transit-gateway-attachment-id "$ATTACH_ID" \
        --region us-east-1 \
        --dry-run
    else
      aws ec2 enable-transit-gateway-route-table-propagation \
        --transit-gateway-route-table-id "$TGW_RT_ID" \
        --transit-gateway-attachment-id "$ATTACH_ID" \
        --region us-east-1
    fi
  else
    echo "Skipping $ATTACH_ID (already propagating)"
  fi
done

