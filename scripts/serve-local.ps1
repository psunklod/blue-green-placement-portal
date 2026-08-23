# Native PowerShell HTTP Server for Local Web Application Preview

param(
    [int]$BluePort = 8081,
    [int]$GreenPort = 8082
)

$BluePath = Resolve-Path "..\app\blue"
$GreenPath = Resolve-Path "..\app\green"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " [LOCAL HOST WEBSITES] Placement Portal Servers" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " Blue v1.0 Website  : http://localhost:$BluePort" -ForegroundColor Cyan
Write-Host " Green v2.0 Website : http://localhost:$GreenPort" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan

function Start-StaticServer {
    param([int]$Port, [string]$Folder, [string]$VersionName)
    
    $Listener = New-Object System.Net.HttpListener
    $Listener.Prefixes.Add("http://localhost:$Port/")
    
    try {
        $Listener.Start()
        Write-Host "[STARTED] $VersionName listening on http://localhost:$Port" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Could not start listener on port $Port : $_" -ForegroundColor Red
        return
    }

    $Task = [System.Threading.Tasks.Task]::Run([Action]{
        while ($Listener.IsListening) {
            try {
                $Context = $Listener.GetContext()
                $Request = $Context.Request
                $Response = $Context.Response

                $FilePath = Join-Path $Folder "index.html"
                if (Test-Path $FilePath) {
                    $Content = [System.IO.File]::ReadAllBytes($FilePath)
                    $Response.ContentType = "text/html; charset=utf-8"
                    $Response.ContentLength64 = $Content.Length
                    $Response.OutputStream.Write($Content, 0, $Content.Length)
                } else {
                    $Response.StatusCode = 404
                }
                $Response.Close()
            } catch {}
        }
    })
    return $Listener
}

$BlueListener = Start-StaticServer -Port $BluePort -Folder $BluePath -VersionName "BLUE v1.0"
$GreenListener = Start-StaticServer -Port $GreenPort -Folder $GreenPath -VersionName "GREEN v2.0"

Write-Host "`nPress Ctrl+C in this terminal window to stop local preview servers.`n" -ForegroundColor Yellow

while ($true) {
    Start-Sleep -Seconds 10
}
