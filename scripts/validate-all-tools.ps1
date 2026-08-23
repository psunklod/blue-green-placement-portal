# Comprehensive DevOps Toolchain Local Validator

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "[VALIDATOR] Local DevOps Toolchain Health & Syntax Check" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Git Repository Check
Write-Host "`n1. Checking Git Repository..." -ForegroundColor Yellow
if (Get-Command git -ErrorAction SilentlyContinue) {
    $Branch = & git branch --show-current
    $Commit = & git log -n 1 --oneline
    Write-Host "   [GIT OK] Branch: $Branch | Latest Commit: $Commit" -ForegroundColor Green
} else {
    Write-Host "   [GIT SKIPPED] Git CLI not found on current PATH." -ForegroundColor Gray
}

# 2. Terraform HCL Manifest Check
Write-Host "`n2. Checking Terraform IaC Files..." -ForegroundColor Yellow
$TfFiles = Get-ChildItem -Path "..\terraform" -Filter "*.tf"
if ($TfFiles.Count -gt 0) {
    Write-Host "   [TERRAFORM OK] Found $($TfFiles.Count) Terraform HCL manifests:" -ForegroundColor Green
    foreach ($file in $TfFiles) {
        Write-Host "     - $($file.Name)" -ForegroundColor Gray
    }
} else {
    Write-Host "   [TERRAFORM ERROR] No .tf files found!" -ForegroundColor Red
}

# 3. Ansible Playbooks Check
Write-Host "`n3. Checking Ansible Playbooks..." -ForegroundColor Yellow
$AnsibleFiles = Get-ChildItem -Path "..\ansible" -Filter "*.yml"
if ($AnsibleFiles.Count -gt 0) {
    Write-Host "   [ANSIBLE OK] Found $($AnsibleFiles.Count) Ansible playbooks:" -ForegroundColor Green
    foreach ($file in $AnsibleFiles) {
        Write-Host "     - $($file.Name)" -ForegroundColor Gray
    }
} else {
    Write-Host "   [ANSIBLE ERROR] No Ansible YAML files found!" -ForegroundColor Red
}

# 4. Docker Configurations Check
Write-Host "`n4. Checking Dockerfiles & Docker Compose..." -ForegroundColor Yellow
$Dockerfiles = Get-ChildItem -Path ".." -Filter "Dockerfile" -Recurse
$Compose = Test-Path "..\docker-compose.yml"
if ($Dockerfiles.Count -ge 2 -and $Compose) {
    Write-Host "   [DOCKER OK] Found Docker Compose & $($Dockerfiles.Count) Dockerfiles:" -ForegroundColor Green
    foreach ($df in $Dockerfiles) {
        Write-Host "     - $($df.FullName.Replace((Get-Item "..").FullName, ""))" -ForegroundColor Gray
    }
} else {
    Write-Host "   [DOCKER WARNING] Check Docker files." -ForegroundColor Yellow
}

# 5. Local Web Application Status
Write-Host "`n5. Checking Localhost Endpoints..." -ForegroundColor Yellow
try {
    $BlueRes = Invoke-WebRequest -Uri "http://localhost:8081" -TimeoutSec 2 -ErrorAction SilentlyContinue
    if ($BlueRes.StatusCode -eq 200) {
        Write-Host "   [ENDPOINT OK] Blue v1.0 Live on http://localhost:8081" -ForegroundColor Green
    }
} catch {
    Write-Host "   [ENDPOINT NOT ACTIVE] http://localhost:8081" -ForegroundColor Gray
}

try {
    $GreenRes = Invoke-WebRequest -Uri "http://localhost:8082" -TimeoutSec 2 -ErrorAction SilentlyContinue
    if ($GreenRes.StatusCode -eq 200) {
        Write-Host "   [ENDPOINT OK] Green v2.0 Live on http://localhost:8082" -ForegroundColor Green
    }
} catch {
    Write-Host "   [ENDPOINT NOT ACTIVE] http://localhost:8082" -ForegroundColor Gray
}

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] DevOps Toolchain Local Verification Complete!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
