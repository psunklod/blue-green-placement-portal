Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[INFO] Starting Deployment of GREEN Environment (v2.0)" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

if (Test-Path "../docker-compose.yml") {
    Write-Host "[INFO] Running docker-compose build for Green..." -ForegroundColor Green
    docker-compose up -d placement-green
}

if (Test-Path "../ansible/inventory.ini") {
    Write-Host "[INFO] Executing Ansible Playbook for Green EC2..." -ForegroundColor Green
    ansible-playbook -i ../ansible/inventory.ini ../ansible/green.yml
}

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] GREEN v2.0 Environment Deployed Successfully!" -ForegroundColor Green
Write-Host "[NOTE] Live public traffic is NOT yet switched to Green. Verify Green first!" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan
