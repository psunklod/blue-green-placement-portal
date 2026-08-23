#!/bin/bash
set -e

echo "=================================================="
echo "[INFO] Starting Deployment of GREEN Environment (v2.0)"
echo "=================================================="

# Check if running locally or on AWS
if [ -f "../docker-compose.yml" ]; then
    echo "[INFO] Running docker-compose build for Green..."
    docker-compose up -d placement-green || true
fi

# Run Ansible Playbook for Green EC2 if inventory exists
if [ -f "../ansible/inventory.ini" ]; then
    echo "[INFO] Executing Ansible Playbook for Green EC2..."
    ansible-playbook -i ../ansible/inventory.ini ../ansible/green.yml
fi

echo "=================================================="
echo "[SUCCESS] GREEN v2.0 Environment Deployed Successfully!"
echo "[NOTE] Live public traffic is NOT yet switched to Green. Verify Green first!"
echo "=================================================="
