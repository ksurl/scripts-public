# replace this with your Uptime Robot API key
$API_KEY = "API_KEY"
$API_URL = "https://api.uptimerobot.com/v2"

function Get-UptimeRobotMonitors {
    $monitors = (Invoke-RestMethod -Uri "$API_URL/getMonitors" -Body @{ api_key = $API_KEY } -Method Post).monitors
    return $monitors
}

function Toggle-UptimeRobotMonitor {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]$Monitor,
        [parameter(Mandatory=$true)]
        [ValidateSet("Pause","Action")]
        [string]$Action
    )
    $monitor_obj = Get-Monitors | Where-Object { $_.friendly_name -eq $Monitor }
    if (!$monitor_obj) {
        Write-Host "Monitor $monitor not found"
        exit 1
    }    
    switch ($Action) {
        "Pause" { $status = 0; $text = "Pausing" }
        "Resume" { $status = 1; $text = "Resuming" }
        default { "Invalid argument for Action"; exit 1 }
    }
    $body = @{
        api_key = $API_KEY
        id = $monitor_obj.id
        status = $status
    }
    Write-Host "$text monitor for $monitor"
    Invoke-RestMethod -Uri "$API_URL/editMonitor" -Body $body -Method Post 
}

function Pause-UptimeRobotMonitor {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]$Monitor
    )
    Toggle-Monitor -Monitor $Monitor -Action Pause
}

function Resume-UptimeRobotMonitor {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Monitor
    )
    Toggle-Monitor -Monitor $Monitor -Action Resume
}
