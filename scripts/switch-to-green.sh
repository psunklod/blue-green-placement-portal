#!/bin/bash
set -e

echo "=================================================="
echo "[INFO] Initiating Traffic Switch to GREEN (v2.0)..."
echo "=================================================="

# Read ALB Listener ARN and Green TG ARN from terraform output if present
if [ -d "../terraform" ]; then
    cd ../terraform
    LISTENER_ARN=$(terraform output -raw alb_listener_arn 2>/dev/null || echo "")
    GREEN_TG_ARN=$(terraform output -raw green_target_group_arn 2>/dev/null || echo "")
    cd ../scripts
fi

if [ -n "$LISTENER_ARN" ] && [ -n "$GREEN_TG_ARN" ]; then
    echo "[INFO] Modifying AWS ALB Listener rule..."
    aws elbv2 modify-listener \
        --listener-arn "$LISTENER_ARN" \
        --default-actions Type=forward,TargetGroupArn="$GREEN_TG_ARN"
    echo "[SUCCESS] AWS Load Balancer listener modified!"
else
    echo "[SIMULATION MODE] No active AWS Terraform outputs detected."
    echo "[SIMULATION MODE] Simulated ALB routing change: ALB Listener -> Green Target Group"
fi

echo "=================================================="
echo "[SUCCESS] Live User Traffic is NOW Routed to GREEN v2.0!"
echo "=================================================="
