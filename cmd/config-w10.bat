reg add hkcu\software\microsoft\windows\currentversion\Search /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f
reg add hkcu\software\microsoft\windows\currentversion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\microsoft\windows\currentversion\Search /v CortanaConsent /t REG_DWORD /d 0 /f

reg delete hkcu\software\microsoft\windows\currentversion\run /v OneDriveSetup /f

reg add hkcu\software\microsoft\GameBar /v AllowAutoGameMode /t REG_DWORD /d 0 /f

reg add hkcu\system\GameConfigStore /v GameDVR_Enabled /t REG_DWORD /d 0 /f

reg add hkcu\software\microsoft\windows\currentversion\Notifications\Settings /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add hkcu\software\microsoft\windows\currentversion\Notifications\Settings /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f

#reg add hkcu\software\microsoft\Siuf\Rules /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
#reg add hkcu\software\microsoft\Siuf\Rules /v PeriodInNanoSeconds /t REG_DWORD /d 0 /f

reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced /v LaunchTo /t REG_DWORD /d 1 /f

reg add hkcu\software\microsoft\windows\currentversion\explorer /v ShowFrequent /t REG_DWORD /d 0 /f
reg add hkcu\software\microsoft\windows\currentversion\explorer /v ShowRecent /t REG_DWORD /d 0 /f

reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced /v HideFileExt /d 0 /t REG_DWORD /f

reg add hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\NewStartPanel /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /d 0 /t REG_DWORD /f
reg add hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\ClassicStartMenu /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /d 0 /t REG_DWORD /f

reg add hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\NewStartPanel /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d 0 /t REG_DWORD /f
reg add hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\ClassicStartMenu /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d 0 /t REG_DWORD /f

reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced /v TaskbarGlomLevel /d 0 /t REG_DWORD /f
reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced /v TaskbarSmallIcons /d 0 /t REG_DWORD /f
reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced /v ShowTaskViewButton /d 0 /t REG_DWORD /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /d 0 /t REG_DWORD /f 
reg add hkcu\software\microsoft\windows\currentversion\explorer\advanced\People /v PeopleBand /d 0 /t REG_DWORD /f

reg add "hkcu\software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FirstRun" /v "LastFirstRunVersionDelivered" /t REG_DWORD /d 1 /f
reg add "hkcu\software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "IE10TourShown" /t REG_DWORD /d 1 /f
reg add "hkcu\software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "DisallowDefaultBrowserPrompt" /t REG_DWORD /d 1 /f

reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v FeatureManagementEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v RemediationRequired /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SoftLandingEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContentEnabled /t REG_DWORD /d 0 /f
reg add hkcu\software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "hkcu\software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy" /v Disabled /t REG_DWORD /d 1 /f

reg add "hklm\software\policies\microsoft\windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
reg add "hklm\software\policies\microsoft\windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f

reg add hklm\software\microsoft\windows\currentversion\DeliveryOptimization\Config /v DODownloadMode /t REG_DWORD /d 0 /f

reg add hklm\software\policies\microsoft\windows\system /v EnableActivityFeed /t REG_DWORD /d 0 /f

powercfg -h off

pause
