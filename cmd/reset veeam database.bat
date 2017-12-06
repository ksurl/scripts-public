net stop veeamendpointbackupsvc
reg add "hklm\software\veeam\veeam endpoint backup" /v RecreateDatabase /d 1 /t REG_DWORD /f
net start veeamendpointbackupsvc
