
$winver = Get-ItemPropertyValue 'hklm:\software\microsoft\windows nt\currentversion' -Name ReleaseId

$oldtile = "1703","1709","1803"
$newtile = "1809"

switch ($winver) {
    { $oldtile -contains $winver } { Remove-Item 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$start.tilegrid$windows.data.curatedtilecollection.root' -Force -Recurse }
    { $newtile -contains $winver } { Remove-Item 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*$start.tilegrid$windows.data.curatedtilecollection.tilecollection'  -Force -Recurse }
    default {
        Write-Host "Windows $winver not supported"
        exit 1
    }
}

Get-Process Explorer | Stop-Process
