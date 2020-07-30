# uses convert-ebook.exe from calibre to convert all specified ebooks to selected format
# example: .\convert-ebooks.ps1 -src "c:\books" -inputformat "epub" -outputformat "mobi"

param([string]$src="$env:userprofile\desktop\calibre",[string]$inputformat="epub",[string]$outputformat="mobi")

$books = Get-ChildItem -Path $src -File "*.$inputformat"

$books | Start-RSJob -Name { $_.basename } -Throttle 8 -ScriptBlock {
    $dst = "$($_.fullname.trimend("$inputformat")).$($outputformat)"
    if (!(Test-Path $dst)) {
        #Write-Host "Converting $($_.name) to $($_.basename).$outputformat"
        ebook-convert.exe $_.FullName $dst
    }
} | Wait-RSJob -ShowProgress

Get-RSJob | Wait-RSJob
