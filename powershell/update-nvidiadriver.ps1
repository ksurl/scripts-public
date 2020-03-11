# This script is designed to install the Nvidia drivers, including Nvidia 3D, HDAudio, and PhysX support
# This will not install Nvidia GeForce or Shadowplay

# Verify user has elevated permissions
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# Checking if 7zip is installed
if (Test-Path $env:programfiles\7-zip\7z.exe) {
    $archiverProgram = "$env:programfiles\7-zip\7z.exe"
} else {
    Write-Host "7-zip is not installed."
    Write-Host "Press any key to exit..."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit
}

# Checking currently installed driver version
Write-Host "Attempting to detect currently installed driver version..."
try {
    $ins_version = (Get-WmiObject Win32_PnPSignedDriver | Where-Object {$_.devicename -like "*nvidia*" -and $_.devicename -notlike "*audio*"}).DriverVersion.SubString(7).Remove(1,1).Insert(3,".")
} catch {
    Write-Host "Unable to detect a compatible Nvidia device."
    Write-Host "Press any key to exit..."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit
}
Write-Host "Installed version `t$ins_version"

# Checking latest driver version from Nvidia website
$link = Invoke-WebRequest -Uri 'https://www.nvidia.com/Download/processFind.aspx?psid=101&pfid=816&osid=57&lid=1&whql=1&lang=en-us&ctk=0' -Method GET
$version = $link.parsedhtml.GetElementsByClassName("gridItem")[2].innerText
Write-Host "Latest version `t`t$version"


# Directory to extract setup files to
$extractDir = "C:\NVIDIA\DisplayDriver\$version\"

# Comparing installed driver version to latest driver version from Nvidia
if($version -eq $ins_version) {
	Write-Host "The installed version is the same as the latest version."
    Write-Host "Press any key to exit..."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit
}

# Checking Windows version
if ([Environment]::OSVersion.Version -ge (new-object 'Version' 9,1)) {
	$windowsVersion = "win10"
} else {
	$windowsVersion = "win8-win7"
}

# Checking OS architecture
if ((Get-WmiObject win32_operatingsystem | Select-Object osarchitecture).osarchitecture -eq "64-bit")
{
	$windowsArchitecture = "64bit"
} else {
	$windowsArchitecture = "32bit"
}

# file to save downloaded driver
$dlFile = "$env:userprofile\Downloads\Nvidia\$version-desktop-$windowsVersion-$windowsArchitecture-international-whql.exe"

# Generating the download link
$url = "http://US.download.nvidia.com/Windows/$version/$version-desktop-$windowsVersion-$windowsArchitecture-international-whql.exe"

# Downloading the installer
Write-Host "Downloading the latest version to $dlFile"
(New-Object System.Net.WebClient).DownloadFile($url, $dlFile)

# Extracting setup files
Write-Host "Download finished, extracting the files now..."
Start-Process -FilePath $archiverProgram -ArgumentList "x $dlFile Display.Driver HDAudio NV3DVision NV3DVisionUSB.Driver NVI2 NVWMI PhysX EULA.txt license.txt ListDevices.txt setup.cfg setup.exe -o""$extractDir\$version\""" -wait

# Installing drivers
Write-Host "Installing Nvidia drivers now..."
$install_args = "-s -noreboot -noeula"
if($cleanInstall){
	$install_args = $install_args + " -clean"
}
Start-Process -FilePath "$extractDir\$version\setup.exe" -ArgumentList $install_args -wait

# Driver installed, requesting a reboot
Write-Host "Driver installed"
Write-Host "Exiting script in 5 seconds"
Start-Sleep -s 5

# End of script
exit
