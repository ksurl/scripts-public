function remove-app ([string]$app) {
    Write-Output "Trying to remove $app" -ForegroundColor Green
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
    Get-AppxPackage -Name $app | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $app } | Remove-AppxProvisionedPackage -Online
}
