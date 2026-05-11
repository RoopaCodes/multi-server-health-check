# Input and Output files
$serverListFile = "servers.txt"
$outputFile = "server_health_report.csv"

# Read server names
$servers = Get-Content $serverListFile

# Empty array for results
$results = @()

foreach ($server in $servers) {

    Write-Host "Checking $server ..."

    # Ping test
    $ping = Test-Connection -ComputerName $server -Count 1 -Quiet

    # Status
    if ($ping) {
        $status = "Reachable"
    }
    else {
        $status = "Not Reachable"
    }

    # Create result object
    $obj = [PSCustomObject]@{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        ServerName = $server
        Reachable = $status
    }

    # Add to results
    $results += $obj
}

# Export report
$results | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host ""
Write-Host "Server health report generated successfully!"
Write-Host "Report File: $outputFile"