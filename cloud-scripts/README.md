# ☁️ Cloud Scripts

This directory contains small scripts to automate AWS cloud tasks.

## Available Scripts


### `create_tgw_association.sh`

Enables filtered TGW attachments on a specified route table.  
Includes a dry-run feature for safe testing.

**Usage:**

```bash
bash create_tgw_association.sh
```
---
### `list_ec2_instances.py`

Lists all EC2 instances in your AWS account, displaying:

- Instance ID
- Instance State (running, stopped, etc.)
- Name (from the EC2 Name tag)
- Public IP Address

**Features:**

- AWS API interaction via `boto3`
- Structured logging output
- Error handling for API failures

**Usage:**

```bash
python3 list_ec2_instances.py
```

---

### `ec2_health_check.sh`

Pings an EC2 instance's public IP address to check if it is reachable.

**Features:**

- Accepts an IP address as a command-line argument
- Sends 3 ICMP packets to check connectivity
- Displays a clear success ✅ or failure ❌ message

**Usage:**

```bash
bash ec2_health_check.sh <EC2_PUBLIC_IP>
```