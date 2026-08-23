#!/bin/bash
set -e

echo "=================================================="
echo "[LOCAL] Switching Localhost Port 80 Traffic to GREEN v2.0..."
echo "=================================================="

# Check if Docker container placement-portal-lb is running
if command -v docker >/dev/null 2>&1 && docker ps | grep -q "placement-portal-lb"; then
    echo "[INFO] Copying Green Nginx proxy config to local load balancer container..."
    docker cp ../app/proxy/nginx-green.conf placement-portal-lb:/etc/nginx/nginx.conf
    echo "[INFO] Reloading local Nginx Load Balancer..."
    docker exec placement-portal-lb nginx -s reload
    echo "[SUCCESS] Local Nginx Load Balancer updated!"
else
    echo "[NOTE] Standard PowerShell HTTP server fallback active."
    echo "[NOTE] To test live Green on localhost: Open http://localhost:8082"
fi

echo "=================================================="
echo "[SUCCESS] Local Traffic Switch Complete! Visit http://localhost"
echo "=================================================="
