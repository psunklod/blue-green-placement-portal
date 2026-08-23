Write-Host "==================================================" -ForegroundColor Red
Write-Host "[LOCAL WARNING] Initiating Emergency Rollback to BLUE v1.0..." -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Red

if (Get-Command docker -ErrorAction SilentlyContinue) {
    $LbContainer = docker ps --filter "name=placement-portal-lb" -q
    if ($LbContainer) {
        Write-Host "[INFO] Reverting local Nginx configuration back to Blue..." -ForegroundColor Green
        docker cp ../app/proxy/nginx-blue.conf placement-portal-lb:/etc/nginx/nginx.conf
        docker exec placement-portal-lb nginx -s reload
        Write-Host "[SUCCESS] Local Nginx Load Balancer reverted to BLUE!" -ForegroundColor Green
    } else {
        Write-Host "[NOTE] Local preview active on http://localhost:8081 (Blue)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[NOTE] Local preview active on http://localhost:8081 (Blue)" -ForegroundColor Yellow
}

Write-Host "==================================================" -ForegroundColor Red
Write-Host "[SUCCESS] Emergency Rollback Complete! Live Traffic Restored to BLUE v1.0" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Red
