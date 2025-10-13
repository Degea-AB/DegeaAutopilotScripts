# Original script created 2024-01-30
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install prerequisite Package provider
try {
    Install-PackageProvider NuGet -MinimumVersion 2.8.5.201 -Force -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "Failed to install NuGet provider. Attempting manual installation."

    # On error, download and install the PackageManagement manually
    $pkgURL = 'https://www.powershellgallery.com/api/v2/package/PackageManagement/1.1.0.0'
    $modulePath = "C:\Program Files\WindowsPowerShell\Modules\PackageManagement"

    $downloadPath = "C:\Temp"
    if (-not (Test-Path -Path $downloadPath)) {
        New-Item -ItemType Directory -Path $downloadPath | Out-Null
    }

    #Unpack the nuget package
    $pkgFile = "$downloadPath\PackageManagement.nupkg"
    Invoke-WebRequest -Uri $pkgURL -OutFile $pkgFile
    Expand-Archive -Path $pkgFile -DestinationPath $modulePath -Force

    # Import the module
    Import-Module PackageManagement -Force
    Write-Host "Successfully installed PackageManagement module."

    # Retry installing the NuGet provider
    Install-PackageProvider NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

    # Clean up
    Remove-Item -Path $pkgFile -Force
    Write-Host "Cleaned up temporary files."

    # Remove temp folder if empty
    if (-not (Get-ChildItem -Path $downloadPath)) {
        Remove-Item -Path $downloadPath -Force
        Write-Host "Removed empty temporary folder."
    }
}

# Install Get-WindowsAutopilotinfo script
try {
    Set-PSRepository PSGallery -InstallationPolicy Trusted -ErrorAction Stop
}
catch {
    Write-Host "Failed to set PSGallery as a trusted repository. Attempting fix."
    Install-Module -Name PowerShellGet -Force -AllowClobber
    Set-PSRepository PSGallery -InstallationPolicy Trusted
}

Install-Script -Name get-WindowsAutoPilotInfo -Force

# Get the first USB drive
$usb = Get-Disk | Where-Object { $_.BusType -eq 'USB' } | Select-Object -First 1

# Assign a variable to the drive letter
$drive = (Get-Partition -DiskNumber $usb.Number).DriveLetter

# Use the variable in other commands
# Get-ChildItem $drive`:\

# Run Get-WindowsAutoPilotInfo and save result on defined USB
Get-WindowsAutoPilotInfo.ps1 -Outputfile "$drive`:\$env:computername.csv"
