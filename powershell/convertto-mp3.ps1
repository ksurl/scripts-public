param(
    [Parameter(Mandatory=$true)]
    [string]$folder
)

Get-ChildItem $folder -File | ForEach-Object { ffmpeg.exe -i $($_.name) -ab 320k "$($_.name.trimend("wav"))mp3" }
