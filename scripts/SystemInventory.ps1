# Create timestamp
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"

# Create output folder
$OutputFolder = "C:\WORK\Inventory"

# Computer Info
$ComputerInfo = Get-ComputerInfo

# Network Info
$IPConfig = ipconfig /all

# Installed Apps
$InstalledApps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, DisplayVersion

# Startup Apps
$StartupApps = Get-CimInstance Win32_StartupCommand |
Select-Object Name, Command

# Disk Info
$DiskInfo = Get-Volume

# System Summary
$SystemSummary = @"
==============================
SYSTEM INVENTORY REPORT
==============================

Computer Name:
$env:COMPUTERNAME

Current User:
$env:USERNAME

Date:
$(Get-Date)

==============================
OPERATING SYSTEM
==============================

$($ComputerInfo.WindowsProductName)
Version: $($ComputerInfo.WindowsVersion)

==============================
CPU
==============================

$($ComputerInfo.CsProcessors.Name)

==============================
RAM
==============================

Total RAM (GB):
$([math]::Round($ComputerInfo.TotalPhysicalMemory / 1GB, 2))

==============================
DISK INFO
==============================

$($DiskInfo | Out-String)

==============================
NETWORK INFO
==============================

$IPConfig

==============================
STARTUP APPS
==============================

$($StartupApps | Out-String)

==============================
INSTALLED APPS
==============================

$($InstalledApps | Out-String)

"@

# Export report
$SystemSummary | Out-File "$OutputFolder\SystemInventory_$Date.txt"

Write-Host ""
Write-Host "System inventory completed!"
Write-Host "Saved to: $OutputFolder"