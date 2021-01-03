cd /d %userprofile%\Downloads
powershell "iwr -uri 'https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US' -outfile FirefoxSetup64.exe"
pause
