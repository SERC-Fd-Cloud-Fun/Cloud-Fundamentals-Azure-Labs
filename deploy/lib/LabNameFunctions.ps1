# script to validate lab names for deployment script
# This script reads the subdirectories in the bicep directory to get the lab names

function Get-LabNames {
    # read subdirectories in the bicep directory to get lab names
    $labNames = Get-ChildItem -Path .\bicep -Directory | Select-Object -ExpandProperty Name
    return $labNames
}

function Test-LabName {
    param (
        [string]$labName
    )

    $labNames = Get-LabNames
    if ($labNames -contains $labName) {
        return $true
    } else {
        Write-Error "Invalid lab name '$labName'. Valid lab names are: $($labNames -join ', ')"
        return $false
    }
}

