@echo off
NET STOP SPOOLER
cd C:\WINDOWS\system32\spool\PRINTERS
del *.shd *.spl
NET START SPOOLER