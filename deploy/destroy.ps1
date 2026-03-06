# PowerShell script for tearing down resources for Azure Labs

# arguments
#    - lab name (e.g. lab01-vm, lab02-storage, lab03-networking) [optional].
#      If not provided, the script will attempt to tear down all labs.
#    - subscription name (optional, default is "Cloud Fundamentals Labs")

param (
    [string]$labName,
    [string]$subscriptionName = "Cloud Fundamentals Labs"
)

# check if azure CLI is installed
if (-Not (Get-Command "az" -ErrorAction SilentlyContinue)) {
    Write-Error "Azure CLI is not installed. Please install Azure CLI to use this teardown script."
    exit 1
}

# Check if lab name is provided and valid (you can add more lab names as needed)
if ($labName) {
    . .\lib\LabNameFunctions.ps1
    if (-Not (Test-LabName -labName $labName)) {
        exit 1
    }
}

# load common Azure functions
. .\lib\AzCommon.ps1

# Set the Azure subscription context
Confirm-AzureLogin
Set-SubscriptionContext -subscriptionID (Get-SubscriptionID -subscriptionName $subscriptionName)


