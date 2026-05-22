$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputFolder = "C:\WORK\Inventory"
$Report = "$OutputFolder\DashboardReport_$Date.html"

$Computer = Get-ComputerInfo
$OS = Get-CimInstance Win32_OperatingSystem
$CPU = Get-CimInstance Win32_Processor
$Disk = Get-PSDrive C
$Startup = Get-CimInstance Win32_StartupCommand | Select-Object Name, Location
$Apps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Where-Object {$_.DisplayName} |
Select-Object DisplayName, DisplayVersion |
Sort-Object DisplayName

$Body = @"
<h1>HP Workstation Dashboard</h1>
<h2>Generated: $(Get-Date)</h2>

<h2>System Summary</h2>
<ul>
<li><b>Computer:</b> $env:COMPUTERNAME</li>
<li><b>User:</b> $env:USERNAME</li>
<li><b>OS:</b> $($Computer.WindowsProductName) $($Computer.WindowsVersion)</li>
<li><b>CPU:</b> $($CPU.Name)</li>
<li><b>Total RAM:</b> $([math]::Round($OS.TotalVisibleMemorySize/1MB,2)) GB</li>
<li><b>Free RAM:</b> $([math]::Round($OS.FreePhysicalMemory/1MB,2)) GB</li>
<li><b>C Drive Free:</b> $([math]::Round($Disk.Free/1GB,2)) GB</li>
<li><b>C Drive Used:</b> $([math]::Round($Disk.Used/1GB,2)) GB</li>
</ul>

<h2>Startup Items</h2>
$($Startup | ConvertTo-Html -Fragment)

<h2>Installed Applications</h2>
$($Apps | ConvertTo-Html -Fragment)
"@

$Html = ConvertTo-Html -Title "HP Workstation Dashboard" -Body $Body

$Html | Out-File $Report

Write-Host "Dashboard report created."
Write-Host "Saved to: $Report"