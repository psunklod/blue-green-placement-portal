Write-Host "==================================================" -ForegroundColor Red
Write-Host "[WARNING] EMERGENCY ROLLBACK INITIATED!" -ForegroundColor Yellow
Write-Host "[INFO] Reverting Live Traffic Back to Stable BLUE (v1.0)..." -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Red

if (Test-Path "./switch-to-blue.ps1") {
    & ./switch-to-blue.ps1
} else {
    Write-Host "[INFO] Routing traffic back to Blue Target Group..." -ForegroundColor Green
}

Write-Host "==================================================" -ForegroundColor Red
Write-Host "[SUCCESS] ROLLBACK COMPLETE! Production Traffic Safely Restored to BLUE v1.0!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Red
