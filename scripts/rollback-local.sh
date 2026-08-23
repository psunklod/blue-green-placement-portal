#!/bin/bash
set -e

echo "=================================================="
echo "[LOCAL WARNING] Initiating Emergency Rollback to BLUE v1.0..."
echo "=================================================="

if command -v docker >/dev/null 2>&1 && docker ps | grep -q "placement-portal-lb"; then
    echo "[INFO] Reverting Nginx proxy config back to Blue..."
    docker cp ../app/proxy/nginx-blue.conf placement-portal-lb:/etc/nginx/nginx.conf
    echo "[INFO] Reloading local Nginx Load Balancer..."
    docker exec placement-portal-lb nginx -s reload
    echo "[SUCCESS] Local Nginx Load Balancer reverted!"
else
    echo "[NOTE] Reverting local preview traffic to Blue (http://localhost:8081)."
fi

echo "=================================================="
echo "[SUCCESS] Emergency Rollback Complete! Live Traffic Restored to BLUE v1.0"
echo "=================================================="
