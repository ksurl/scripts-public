function touch ($file){New-Item -ItemType File -Name $file}
function which ($cmd) {Get-Command $cmd | select path}
function sudo ($cmd) {Start-Process $cmd -Verb runas }
function rm-rf ($item) {Remove-Item $item -Recurse -Force}
set-alias grep select-string
