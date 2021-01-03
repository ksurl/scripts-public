param(
    [string]$user,
    [string]$repo,
    [string]$destination
)

$download_url = ((Invoke-WebRequest -Uri "https://api.github.com/repos/$user/$repo/releases/latest").content | ConvertFrom-Json).assets.browser_download_url

Invoke-Expression ((New-Object net.webclient).DownloadString($download_url, $destination)
