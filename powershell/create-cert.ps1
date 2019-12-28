param(
    [string]$domain,
    [int]$years
)

$date = (Get-Date).AddYears($years)
$cert = New-SelfSignedCertificate -DnsName $domain -CertStoreLocation Cert:\LocalMachine\my -NotAfter $date
$pw = Read-Host -AsSecureString
Export-PfxCertificate -Cert "Cert:\LocalMachine\My\$($cert.thumbprint)" -FilePath $env:userprofile\Desktop -Password $pw
