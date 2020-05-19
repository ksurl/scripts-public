param([string]$comic)

$folders = Get-ChildItem -Path $comic -Directory | Sort-Object 

foreach ($folder in $folders) {
    if (!(Test-Path -Path "$comic\$($folder.basename).cbz")) {
        Compress-Archive -Path $folder.fullname -DestinationPath "$comic\$($folder.basename).zip"
        Rename-Item -Path "$comic\$($folder.basename).zip" -NewName "$comic\$($folder.basename).cbz"
    }    
}
