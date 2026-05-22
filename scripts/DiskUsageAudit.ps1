$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputFolder = "C:\WORK\Inventory"

Get-ChildItem C:\ -Recurse -ErrorAction SilentlyContinue |
Where-Object { -not $_.PSIsContainer -and $_.Length -gt 100MB } |
Select-Object FullName, @{Name="SizeMB";Expression={[math]::Round($_.Length / 1MB,2)}}, LastWriteTime |
Sort-Object SizeMB -Descending |
Out-File "$OutputFolder\DiskUsageAudit_$Date.txt"

Write-Host "Disk usage audit completed!"
Write-Host "Saved to: $OutputFolder"