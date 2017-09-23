rmdir /q /s C:\Users\%username%\AppData\Roaming\Macromedia
ipconfig /flushdns
net stop dnscache
net start dnscache