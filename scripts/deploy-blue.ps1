Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[INFO] Starting Deployment of BLUE Environment (v1.0)" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

if (Test-Path "../docker-compose.yml") {
    Write-Host "[INFO] Running docker-compose build for Blue..." -ForegroundColor Green
    docker-compose up -d placement-blue
}

if (Test-Path "../ansible/inventory.ini") {
    Write-Host "[INFO] Executing Ansible Playbook for Blue EC2..." -ForegroundColor Green
    ansible-playbook -i ../ansible/inventory.ini ../ansible/blue.yml
}

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] BLUE v1.0 Environment Deployed Successfully!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
