#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: ./push-to-dockerhub.sh <your-dockerhub-username>"
    exit 1
fi

DOCKER_USER=$1

echo "=================================================="
echo "[DOCKER HUB] Building and Pushing Docker Images Globally..."
echo "=================================================="

BLUE_IMAGE="$DOCKER_USER/placement-portal:blue"
BLUE_V1="$DOCKER_USER/placement-portal:v1.0"
GREEN_IMAGE="$DOCKER_USER/placement-portal:green"
GREEN_V2="$DOCKER_USER/placement-portal:v2.0"

echo "[INFO] Building Blue v1.0 Image..."
docker build -t "$BLUE_IMAGE" -t "$BLUE_V1" ../app/blue

echo "[INFO] Building Green v2.0 Image..."
docker build -t "$GREEN_IMAGE" -t "$GREEN_V2" ../app/green

echo "[INFO] Pushing Blue Images to Docker Hub..."
docker push "$BLUE_IMAGE"
docker push "$BLUE_V1"

echo "[INFO] Pushing Green Images to Docker Hub..."
docker push "$GREEN_IMAGE"
docker push "$GREEN_V2"

echo "=================================================="
echo "[SUCCESS] Docker Images Published Globally on Docker Hub!"
echo "Repository: https://hub.docker.com/r/$DOCKER_USER/placement-portal"
echo "=================================================="
