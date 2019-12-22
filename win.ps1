function Update-ItemProperty($path, $name, $type, $value) {
    if (!(Test-Path $path)) {
        New-Item $path -force | Out-Null
    }

    if ((Get-ItemProperty $path).PSObject.Properties.Name -contains $name) {
        Set-ItemProperty $path -Name $name -Value $value | Out-Null
    }
    else {
        New-ItemProperty $path -PropertyType $type -Name $name -Value $value | Out-Null
    }
}

### Configure desktop ###
#  Don't show Cortana search bar
Update-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' 'SearchboxTaskbarMode' 'DWORD' 0

# Show file extensions and hidden files
Update-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'HideFileExt' 'DWORD' 0
Update-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'Hidden' 'DWORD' 1
Update-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'ShowSuperHidden' 'DWORD' 1

# Default desktop icons
$MyComputerDesktopIcon = '{20D04FE0-3AEA-1069-A2D8-08002B30309D}'
$UserDesktopIcon = '{59031a47-3f72-44a7-89c5-5595fe6b30ee}'
$RecycleBinDesktopIcon = '{645FF040-5081-101B-9F08-00AA002F954E}'
$NetworkDesktopIcon = '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}'
$ControlPanelDesktopIcon = '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}'

Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' $MyComputerDesktopIcon 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' $UserDesktopIcon 'DWORD' 0

# Hide 3D objects in Explorer's sidebar
$3dobj = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
$3dObjWow64 = 'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
if (Test-Path $3dobj) {
    Remove-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
}

if (Test-Path $3dObjWow64) {
    Remove-Item -Path 'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
}

### Updates ###
# Check for updates, but download and install only on demand. Automatic reboot is disabled.
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' 'AUOptions' 'DWORD' 2
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' 'NoAutoRebootWithLoggedOnUsers' 'DWORD' 1
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\DeliveryOptimization' 'DODownloadMode' 'DWORD' 0
Update-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config' 'DODownloadMode' 'DWORD' 0

### Privacy ###
# Disable Collect Activity 
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\System' 'PublishUserActivities' 'DWORD' 0
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\System' 'UploadUserActivities' 'DWORD' 0
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\System' 'EnableActivityFeed' 'DWORD' 0
# Disable telemetry
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 'DWORD' 0
Set-Service DiagTrack -StartupType Disabled
Stop-Service DiagTrack
# Disable DMW Push service
Set-Service dmwappushservice -StartupType Disabled
Stop-Service dmwappushservice

### Remove built-in bloatware ###
Get-AppxPackage *bubblewitch*| Remove-AppxPackage
Get-AppxPackage *candycrush* | Remove-AppxPackage
Get-AppxPackage *spotify* | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage Microsoft.Advertising.Xaml | Remove-AppxPackage
Get-AppxPackage Microsoft.Todos | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms| Remove-AppxPackage
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

# Remove OneDrive #
# Kill onedrive process
$onedrive = Get-Process onedrive -ErrorAction SilentlyContinue
if ($onedrive) {
    taskkill.exe /F /IM "OneDrive.exe" | Out-Null
}
# Uninstall OneDrive
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}
# Disable OneDrive via Group Policies
Update-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive' 'DisableFileSyncNGSC' 'DWORD' 1
# Remove OneDrive leftover directories
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"
# Remove startmenu entry
rm -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
# Remove OneDrive directory from user home
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"

### Disable bloatware installing and advertising
# Don't silently install more bloatware
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'ContentDeliveryAllowed' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'OemPreInstalledAppsEnabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'PreInstalledAppsEnabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'PreInstalledAppsEverEnabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SilentInstalledAppsEnabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SystemPaneSuggestionsEnabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SubscribedContent-338388Enabled' 'DWORD' 0
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SubscribedContent-338389Enabled' 'DWORD' 0
# for new users
Update-ItemProperty 'Registry::HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SystemPaneSuggestionsEnabled' 'DWORD' 0
Update-ItemProperty 'Registry::HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'PreInstalledAppsEnabled' 'DWORD' 0
Update-ItemProperty 'Registry::HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'OemPreInstalledAppsEnabled' 'DWORD' 0

# Disable tips
Update-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SoftLandingEnabled' 'DWORD' 0

# Disable Consumer experience to prevent "Suggested Applications" returning
Update-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent' 'DisableWindowsConsumerFeatures' 'DWORD' 1