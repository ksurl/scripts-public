rem change paths, filters, and url as needed
youtube-dl --download-archive "d:\videos\youtube\channel\archive.txt" --match-title "title" --reject-title "skip" -o "d:\videos\youtube\channel\%%(uploader)s - %%(title)s.%%(ext)s" https://www.youtube.com/user/channel
pause
