# Original script created 2024-01-30
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install prerequisite Package provider
Install-PackageProvider NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

# Install Get-WindowsAutopilotinfo script
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Script -Name get-WindowsAutoPilotInfo -Force

# Get the first USB drive
$usb = Get-Disk | Where-Object { $_.BusType -eq 'USB' } | Select-Object -First 1

# Assign a variable to the drive letter
$drive = (Get-Partition -DiskNumber $usb.Number).DriveLetter

# Use the variable in other commands
# Get-ChildItem $drive`:\

# Run Get-WindowsAutoPilotInfo and save result on defined USB
Get-WindowsAutoPilotInfo.ps1 -Outputfile "$drive`:\$env:computername.csv"
