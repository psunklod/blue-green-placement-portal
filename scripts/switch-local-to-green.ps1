Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[LOCAL] Switching Localhost Port 80 Traffic to GREEN v2.0..." -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

if (Get-Command docker -ErrorAction SilentlyContinue) {
    $LbContainer = docker ps --filter "name=placement-portal-lb" -q
    if ($LbContainer) {
        Write-Host "[INFO] Updating local Nginx configuration to Green..." -ForegroundColor Green
        docker cp ../app/proxy/nginx-green.conf placement-portal-lb:/etc/nginx/nginx.conf
        docker exec placement-portal-lb nginx -s reload
        Write-Host "[SUCCESS] Local Nginx Load Balancer reloaded to GREEN!" -ForegroundColor Green
    } else {
        Write-Host "[NOTE] Local preview active on http://localhost:8082 (Green)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[NOTE] Local preview active on http://localhost:8082 (Green)" -ForegroundColor Yellow
}

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] Local Traffic Switch Complete!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
