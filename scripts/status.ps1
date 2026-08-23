Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[STATUS REPORT] Blue-Green Infrastructure Inspector" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

Write-Host "`n--- Docker Container Status ---" -ForegroundColor Green
if (Get-Command docker -ErrorAction SilentlyContinue) {
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
} else {
    Write-Host "Docker CLI not detected on host path." -ForegroundColor Gray
}

Write-Host "`n--- Local App Endpoints (Docker Compose) ---" -ForegroundColor Green
Write-Host "Blue v1.0 (Local):  http://localhost:8081" -ForegroundColor Cyan
Write-Host "Green v2.0 (Local): http://localhost:8082" -ForegroundColor Green

Write-Host "`n--- Terraform AWS Status ---" -ForegroundColor Green
if (Test-Path "../terraform") {
    Push-Location "../terraform"
    $AlbDns = (terraform output -raw alb_dns_name 2>$null)
    $BlueIp = (terraform output -raw blue_ec2_public_ip 2>$null)
    $GreenIp = (terraform output -raw green_ec2_public_ip 2>$null)
    Pop-Location

    Write-Host "ALB DNS:     $($AlbDns ? $AlbDns : 'N/A')" -ForegroundColor Yellow
    Write-Host "Blue EC2 IP: $($BlueIp ? $BlueIp : 'N/A')" -ForegroundColor Cyan
    Write-Host "Green EC2 IP:$($GreenIp ? $GreenIp : 'N/A')" -ForegroundColor Green
}

Write-Host "==================================================" -ForegroundColor Cyan
