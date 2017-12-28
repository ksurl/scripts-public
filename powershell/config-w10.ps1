# this script configures a new Windows 10 install

# remove apps
Write-Host "Removing default apps" -ForegroundColor Cyan
$apps = @(
    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    #"Microsoft.BingWeather"
    "Microsoft.FreshPaint"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.MicrosoftStickyNotes"
    #"Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    #"Microsoft.Windows.Photos"
    #"Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    #"Microsoft.WindowsSoundRecorder"
    #"Microsoft.WindowsStore"
    #"Microsoft.XboxApp"
    #"Microsoft.ZuneMusic"
    #"Microsoft.ZuneVideo"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    "Microsoft.WindowsFeedbackHub"

    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    
    # Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingTravel"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.WindowsReadingList"
    "Microsoft.RemoteDesktop"
    "Microsoft.MicrosoftPowerBIForWindows"

    # non-Microsoft
    "PandoraMediaInc.29680B314EFC2"
    "4DF9E0F8.Netflix"
    "6Wunderkinder.Wunderlist"
    "Duolingo"
    "46928bounde.EclipseManager"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "Drawboard.DrawboardPDF"
    "2FE3CB00.PicsArt-PhotoStudio"
    "D52A8D61.FarmVille2CountryEscape"
    "TuneIn.TuneInRadio"
    "GAMELOFTSA.Asphalt8Airborne"
    "*.Twitter"
    "Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "king.com.*"
    "ClearChannelRadioDigital.iHeartRadio"
    "TheNewYorkTimes.NYTCrossword"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "ActiproSoftwareLLC.562882FEEB491"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "Facebook.Facebook"
    "flaregamesGmbH.RoyalRevolt2"
    "Playtika.CaesarsSlotsFreeCasino"
    "A278AB0D.MarchofEmpires"
    "KeeperSecurityInc.Keeper"
    "ThumbmunkeysLtd.PhototasticCollage"
    "XINGAG.XING"
    "89006A2E.AutodeskSketchBook"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "DolbyLaboratories.DolbyAccess"
    "SpotifyAB.SpotifyMusic"
    "A278AB0D.DisneyMagicKingdoms"
    "WinZipComputing.WinZipUniversal"
    
    # apps which cannot be removed using Remove-AppxPackage
    #"Microsoft.BioEnrollment"
    #"Microsoft.MicrosoftEdge"
    #"Microsoft.Windows.Cortana"
    #"Microsoft.WindowsFeedback"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.XboxIdentityProvider"
    #"Windows.ContactSupport"
)

foreach ($app in $apps) {
    Write-Host "Trying to remove $app" -ForegroundColor Green
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage
    Get-AppxPackage -Name $app | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -eq $app | Remove-AppxProvisionedPackage -Online
}

# disable services
Write-Host "Disabling services" -ForegroundColor Cyan
$services = @(
    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                # Diagnostics Tracking Service
    "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
    "HomeGroupListener"                        # HomeGroup Listener
    "HomeGroupProvider"                        # HomeGroup Provider
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Downloaded Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "SharedAccess"                             # Internet Connection Sharing (ICS)
    "TrkWks"                                   # Distributed Link Tracking Client
    "WbioSrvc"                                 # Windows Biometric Service
    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
)

foreach ($service in $services) {
    Write-Host "Trying to disable $service" -ForegroundColor Green
    Get-Service -Name $service | Set-Service -StartupType Disabled
}

# Disable App Auto-install after 1st login
Write-Host "Disabling App Auto-install after 1st login" -ForegroundColor Green
reg add HKLM\Software\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
Write-Host ""

# Disable OneDrive
Write-Host "Disabling OneDrive..." -ForegroundColor Green
reg add hklm\software\policies\microsoft\windows\OneDrive /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f
Write-Host ""

# Configure user registry
Write-Host "Configuring user registry" -ForegroundColor Cyan
# Disable OneDrive Setup
Write-Host "Disabling OneDrive setup on login..." -ForegroundColor Green
reg delete "hkcu\software\microsoft\windows\currentversion\run" /v "OneDriveSetup" /f
# Disable Game Mode
Write-Host "Disabling Game Mode..." -ForegroundColor Green
reg add "hkcu\software\microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f
# Disable lock screen notifications
Write-Host "Disabling lock screen notifications..." -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "hkcu\software\microsoft\windows\currentversion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
# Set feedback frequency to never
Write-Host "Setting feedback frequency to never..." -ForegroundColor Green
reg add "hkcu\software\microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "hkcu\software\microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f
# Set Explorer default to This PC instead of Quick Access
Write-Host "Changing default Explorer view to This PC..." -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v LaunchTo /t REG_DWORD /d 1 /f
# Disable show frequent/recent files/folders in Quick Access
Write-Host "Disabling show recent files/folders in Quick Access..." -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer" /v ShowFrequent /t REG_DWORD /d 0 /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer" /v ShowRecent /t REG_DWORD /d 0 /f
# Show file extension in explorer
Write-Host "Show file extensions in File Explorer" -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v HideFileExt /d 0 /t REG_DWORD /f
# Show user files shortcut on desktop
Write-Host "Show user folder and This PC on desktop" -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /d 0 /t REG_DWORD /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\ClassicStartMenu" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /d 0 /t REG_DWORD /f
# Show This PC shortcut on desktop
Write-Host "Show This PC and User folder icons on desktop" -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d 0 /t REG_DWORD /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer\HideDesktopIcons\ClassicStartMenu" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d 0 /t REG_DWORD /f
# Set taskbar settings
Write-Host "Set taskbar settings: always combine, large icons, hide search and taskview" -ForegroundColor Green
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v TaskbarGlomLevel /d 0 /t REG_DWORD /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v TaskbarSmallIcons /d 0 /t REG_DWORD /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v ShowTaskViewButton /d 0 /t REG_DWORD /f
reg add "hkcu\software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /d 0 /t REG_DWORD /f 
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced\People" /v PeopleBand /d 0 /t REG_DWORD /f
Write-Host ""

# Disable Cortana:
Write-Host "Disable Cortana" -ForegroundColor Cyan
reg add "hklm\software\policies\microsoft\windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
Write-Host ""

# Disable Sign-in Animation
Write-Host "Disabling First Sign-in Animation" -ForegroundColor Green
reg add hklm\software\microsoft\windows\currentversion\policies\system /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f
Write-Host ""

# Disable Hibernate
Write-Host "Disabling Hibernate..." -ForegroundColor Green
POWERCFG -h off
Write-Host ""

# Configure Search Options:
Write-Host "Configuring Search Options..." -ForegroundColor Green
reg add "hklm\software\policies\microsoft\windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f
reg add "hklm\software\policies\microsoft\windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f
Write-Host ""

# Disable suggested apps
Write-Host "Disable suggested apps" -ForegroundColor Green
reg add "hklm\software\policies\microsoft\windows\Cloud Content" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
Write-Host ""

# Restart Explorer
Write-Host "Restarting Explorer" -ForegroundColor Cyan
Stop-Process -Name "explorer"
Write-Host ""

Write-Host "Configuration complete. Please reboot to take effect." -ForegroundColor Magenta
