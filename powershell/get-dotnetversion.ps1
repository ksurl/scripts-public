$release = Get-ItemPropertyValue -Path "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -Name Release

switch($release) {
    378389 { Write-Host ".NET Framework 4.5" }
    378675 { Write-Host ".NET Framework 4.5.1" }
    379893 { Write-Host ".NET Framework 4.5.2" }
    393295 { Write-Host ".NET Framework 4.6" }
    394254 { Write-Host ".NET Framework 4.6.1" }
    394802 { Write-Host ".NET Framework 4.6.2" }
    460798 { Write-Host ".NET Framework 4.7" }
    461308 { Write-Host ".NET Framework 4.7.1" }
    461808 { Write-Host ".NET Framework 4.7.2" }
}
