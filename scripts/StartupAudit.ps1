$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputFolder = "C:\WORK\Inventory"

Get-CimInstance Win32_StartupCommand |
Select-Object Name, Command, Location |
Sort-Object Name |
Out-File "$OutputFolder\StartupAudit_$Date.txt"

Write-Host "Startup audit completed!"
Write-Host "Saved to: $OutputFolder"