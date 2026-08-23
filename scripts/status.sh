#!/bin/bash

echo "=================================================="
echo "[STATUS REPORT] Blue-Green Infrastructure Inspector"
echo "=================================================="

echo ""
echo "--- Docker Container Status ---"
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "Docker CLI not detected locally."
fi

echo ""
echo "--- Terraform AWS Status ---"
if [ -d "../terraform" ] && command -v terraform >/dev/null 2>&1; then
    cd ../terraform
    echo "ALB DNS: $(terraform output -raw alb_dns_name 2>/dev/null || echo 'N/A')"
    echo "Blue EC2 IP: $(terraform output -raw blue_ec2_public_ip 2>/dev/null || echo 'N/A')"
    echo "Green EC2 IP: $(terraform output -raw green_ec2_public_ip 2>/dev/null || echo 'N/A')"
    cd ../scripts
else
    echo "Terraform state not active."
fi

echo "=================================================="
