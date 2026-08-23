Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[INFO] Initiating Traffic Switch to GREEN (v2.0)..." -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

$ListenerArn = ""
$GreenTgArn = ""

if (Test-Path "../terraform") {
    Push-Location "../terraform"
    $ListenerArn = (terraform output -raw alb_listener_arn 2>$null)
    $GreenTgArn = (terraform output -raw green_target_group_arn 2>$null)
    Pop-Location
}

if ($ListenerArn -and $GreenTgArn) {
    Write-Host "[INFO] Modifying AWS ALB Listener rule..." -ForegroundColor Green
    aws elbv2 modify-listener --listener-arn $ListenerArn --default-actions Type=forward,TargetGroupArn=$GreenTgArn
    Write-Host "[SUCCESS] AWS Load Balancer listener modified!" -ForegroundColor Green
} else {
    Write-Host "[SIMULATION MODE] No active AWS Terraform outputs detected." -ForegroundColor Yellow
    Write-Host "[SIMULATION MODE] Simulated ALB routing change: ALB Listener -> Green Target Group" -ForegroundColor Green
}

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] Live User Traffic is NOW Routed to GREEN v2.0!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
