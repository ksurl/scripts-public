# assumes Convert-IntegersToWords module is in same folder as this script

$SourceURLPrefix = "http://musicforprogramming.net/?"

Import-Module "$PSScriptRoot\Convert-IntegerToWords.psm1"

for ($i -eq 1; $i -le 53; $i++) {
    $SourceSuffix = Convert-IntegerToWords -number $i
    $SourceURL = $SourceURLPrefix + $SourceSuffix
    $DownloadLink = (Invoke-WebRequest -Uri $SourceURL).Links | Where-Object { $_.href -like "http*mp3" }
    Write-Output "Downloading $($DownloadLink.innerText)"
    #Invoke-WebRequest -Uri $DownloadLink.href -OutFile "$env:userprofile\Desktop\$($DownloadLink.innerText)"
    (New-Object System.Net.WebClient).DownloadFile("$($DownloadLink.href)","$env:userprofile\Desktop\$($DownloadLink.innerText)")
}
