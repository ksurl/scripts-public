# uses convert-ebook.exe from calibre to convert all specified ebooks to selected format
# example: .\convert-ebooks.ps1 -src "c:\books" -inputformat "epub" -outputformat "mobi"

param([string]$src=$PSScriptRoot,[string]$inputformat="epub",[string]$outputformat="mobi")

$books = Get-ChildItem -Path $src -Include "*.$inputformat" -Recurse

foreach ($book in $books) {
    $dst = "$($book.directory)\$($book.basename).$outputformat"
    if (!(Test-Path $dst)) {
        Write-Host "Converting $($book.name) to $($book.basename).$outputformat"
        ebook-convert.exe $book.fullname $dst
    }
}
