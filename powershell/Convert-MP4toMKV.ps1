param(
    [Parameter(Mandatory=$true)]
    [string]$path,
    [Parameter(Mandatory=$true)]
    [int]$days
)

$movies = Get-ChildItem $path -Recurse *mp4 | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays($days) }

foreach ($movie in $movies) {
    if (!(Test-Path $movie.FullName.Replace("mp4","mkv"))) {
        Write-Host "Converting $($movie.name)" -ForegroundColor Cyan
        & "C:\Program Files\MKVToolNix\mkvmerge.exe" -o $movie.FullName.Replace("mp4","mkv") $movie.FullName
        #& "C:\programdata\chocolatey\bin\ffmpeg.exe" -i $movie.FullName -i $movie.FullName.Replace("mp4","mkv") -map 1 -map 0 -map -0:v:0 -map -1:v:1 -map_metadata 0 -c copy -tag:v:0 hvc1 -movflags +faststart -f mp4 $movie.FullName.Replace("mp4","m4v")
    }    
}
