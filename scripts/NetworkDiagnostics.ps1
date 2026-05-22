$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputFolder = "C:\WORK\Inventory"
$Report = "$OutputFolder\NetworkDiagnostics_$Date.txt"

"NETWORK DIAGNOSTICS REPORT - $(Get-Date)" | Out-File $Report
"========================================" | Out-File $Report -Append

"`nIP CONFIG:" | Out-File $Report -Append
ipconfig /all | Out-File $Report -Append

"`nADAPTER STATUS:" | Out-File $Report -Append
Get-NetAdapter | Format-Table Name, Status, LinkSpeed, MacAddress -AutoSize | Out-File $Report -Append

"`nDNS SERVERS:" | Out-File $Report -Append
Get-DnsClientServerAddress | Format-Table InterfaceAlias, ServerAddresses -AutoSize | Out-File $Report -Append

"`nPING TESTS:" | Out-File $Report -Append
Test-Connection 8.8.8.8 -Count 4 | Out-File $Report -Append
Test-Connection google.com -Count 4 | Out-File $Report -Append

Write-Host "Network diagnostics completed."
Write-Host "Saved to: $Report"