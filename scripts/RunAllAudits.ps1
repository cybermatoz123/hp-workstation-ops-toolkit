powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\SystemInventory.ps1"
powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\StartupAudit.ps1"
powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\DiskUsageAudit.ps1"
powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\CleanupDownloads.ps1"
powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\NetworkDiagnostics.ps1"

Write-Host "All audits completed."
Write-Host "Reports saved to C:\WORK\Inventory"

powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\SystemHealth.ps1"



















powershell -ExecutionPolicy Bypass -File "C:\SCRIPTS\DashboardReport.ps1"