# Description: This script removes unwanted apps that come with Windows 10. If you do not want to remove certain apps, comment out the corresponding lines below.
# Usage: powershell -executionpolicy bypass -file "path\remove-defaultapps.ps1"

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
    "4DF9E0F8.Netflix"
    "Drawboard.DrawboardPDF"
    "TheNewYorkTimes.NYTCrossword"

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

# Disable App Auto-install after 1st login
Write-Host "Disabling App Auto-install after 1st login"
reg add HKLM\Software\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
Write-Host ""

# end of script
