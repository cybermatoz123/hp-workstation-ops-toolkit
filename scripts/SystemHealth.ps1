$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputFolder = "C:\WORK\Inventory"
$Report = "$OutputFolder\SystemHealth_$Date.txt"

"_SYSTEM HEALTH REPORT - $(Get-Date)" | Out-File $Report
"======================================" | Out-File $Report -Append

"`nUPTIME:" | Out-File $Report -Append
(Get-CimInstance Win32_OperatingSystem).LastBootUpTime | Out-File $Report -Append

"`nCPU:" | Out-File $Report -Append
Get-CimInstance Win32_Processor |
Select-Object Name, LoadPercentage |
Out-File $Report -Append

"`nRAM:" | Out-File $Report -Append
Get-CimInstance Win32_OperatingSystem |
Select-Object @{
Name="TotalRAMGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}
}, @{
Name="FreeRAMGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}
} |
Out-File $Report -Append

"`nDISK SPACE:" | Out-File $Report -Append
Get-PSDrive C |
Select-Object Name, @{
Name="UsedGB";Expression={[math]::Round(($_.Used/1GB),2)}
}, @{
Name="FreeGB";Expression={[math]::Round(($_.Free/1GB),2)}
} |
Out-File $Report -Append

"`nTOP 10 PROCESSES BY CPU:" | Out-File $Report -Append
Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10 Name, CPU, Id |
Out-File $Report -Append

"`nTOP 10 PROCESSES BY MEMORY:" | Out-File $Report -Append
Get-Process |
Sort-Object WorkingSet -Descending |
Select-Object -First 10 Name, @{
Name="MemoryMB";Expression={[math]::Round($_.WorkingSet/1MB,2)}
}, Id |
Out-File $Report -Append

Write-Host "System health report completed."
Write-Host "Saved to: $Report"