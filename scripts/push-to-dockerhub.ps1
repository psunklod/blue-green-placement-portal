# Script to Build, Tag, and Push Docker Images Globally to Docker Hub

param(
    [Parameter(Mandatory=$true)]
    [string]$DockerUsername
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[DOCKER HUB] Building and Pushing Docker Images Globally..." -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

$BlueImage = "$DockerUsername/placement-portal:blue"
$BlueTagV1 = "$DockerUsername/placement-portal:v1.0"
$GreenImage = "$DockerUsername/placement-portal:green"
$GreenTagV2 = "$DockerUsername/placement-portal:v2.0"

# 1. Build and Tag Blue v1.0
Write-Host "`n1. Building Blue v1.0 Docker Image..." -ForegroundColor Green
docker build -t $BlueImage -t $BlueTagV1 ../app/blue

# 2. Build and Tag Green v2.0
Write-Host "`n2. Building Green v2.0 Docker Image..." -ForegroundColor Green
docker build -t $GreenImage -t $GreenTagV2 ../app/green

# 3. Push Blue Images to Docker Hub
Write-Host "`n3. Pushing Blue Images to Docker Hub..." -ForegroundColor Yellow
docker push $BlueImage
docker push $BlueTagV1

# 4. Push Green Images to Docker Hub
Write-Host "`n4. Pushing Green Images to Docker Hub..." -ForegroundColor Yellow
docker push $GreenImage
docker push $GreenTagV2

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] Docker Images Published Globally on Docker Hub!" -ForegroundColor Green
Write-Host "  Blue Image : https://hub.docker.com/r/$DockerUsername/placement-portal" -ForegroundColor Cyan
Write-Host "  Tags       : blue, v1.0, green, v2.0" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
