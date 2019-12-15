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
