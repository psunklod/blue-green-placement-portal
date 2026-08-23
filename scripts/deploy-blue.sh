#!/bin/bash
set -e

echo "=================================================="
echo "[INFO] Starting Deployment of BLUE Environment (v1.0)"
echo "=================================================="

# Check if running locally or on AWS
if [ -f "../docker-compose.yml" ]; then
    echo "[INFO] Running docker-compose build for Blue..."
    docker-compose up -d placement-blue || true
fi

# Run Ansible Playbook for Blue EC2 if inventory exists
if [ -f "../ansible/inventory.ini" ]; then
    echo "[INFO] Executing Ansible Playbook for Blue EC2..."
    ansible-playbook -i ../ansible/inventory.ini ../ansible/blue.yml
fi

echo "=================================================="
echo "[SUCCESS] BLUE v1.0 Environment Deployed Successfully!"
echo "=================================================="
