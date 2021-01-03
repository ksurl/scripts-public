REM change paths, filters, and url as needed
youtube-dl --download-archive "d:\podcasts\podcast\archive.txt" --extract-audio --audio-format mp3 --ffmpeg-location "c:\ffmpeg\bin" --playlist-items 1-15 --match-title "podcastname" --reject-title "skip1|skip2" --dateafter 20170909 -o "d:\podcasts\podcast\%%(title)s.%%(ext)s"  https://www.youtube.com/playlist?list=podcastplaylistid
pause
