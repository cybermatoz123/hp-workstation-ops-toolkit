$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$Downloads = "$env:USERPROFILE\Downloads"
$ReportFolder = "C:\WORK\Inventory"
$ArchiveFolder = "C:\ARCHIVE\Downloads_Cleanup_$Date"

New-Item -Path $ArchiveFolder -ItemType Directory -Force | Out-Null

$Rules = @{
    "MOVE_TO_THINKPAD" = "Nessus|Wireshark|Sysinternals|ProcessExplorer|Advanced_IP|putty|PowerShell|CompTIA|TIA\+|Mapsscraper|Maps-Scraper|Bolt|ubuntu|SERVER|iso"
    "MOVE_TO_MACBOOK" = "FANCLAP|Roofing|Proposal|Retainer|Intake|Consultation|Cloudflare|Lovable|Contacts|keywords|leads|Julio Matos|Resume|TTHS|Court|Move-money|mazz"
    "WORK_KEEP" = "Lorge|School|SNAP|IEP|Behavior|Endpoint|ManageEngine|RMM|AnyDesk|WindowsAdminCenter|IT_Mentorship|EdTech|Calendar|Handbook|Web Phone|Academics|Apply"
    "DELETE_OR_ARCHIVE" = "Password|recovery-codes|Okara|ChromeAutoLaunch|system\.conf\.lock|files\.zip|index\.html|User_Download"
}

foreach ($folder in $Rules.Keys) {
    $target = Join-Path $Downloads $folder
    New-Item -Path $target -ItemType Directory -Force | Out-Null
}

$MovedItems = @()

Get-ChildItem $Downloads -File | ForEach-Object {
    $file = $_
    foreach ($folder in $Rules.Keys) {
        if ($file.Name -match $Rules[$folder]) {
            Move-Item $file.FullName -Destination (Join-Path $Downloads $folder) -Force
            $MovedItems += [PSCustomObject]@{
                File = $file.Name
                Destination = $folder
                Date = Get-Date
            }
            break
        }
    }
}

$MovedItems | Format-Table -AutoSize | Out-File "$ReportFolder\CleanupDownloads_$Date.txt"

Write-Host "Downloads cleanup completed."
Write-Host "Report saved to: $ReportFolder"