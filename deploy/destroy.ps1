# PowerShell script for tearing down resources for Azure Labs

# arguments
#    - lab name (e.g. lab01-vm, lab02-storage, lab03-networking) [optional].
#      If not provided, the script will attempt to tear down all labs.
#    - subscription name (optional, default is "Cloud Fundamentals Labs")

param (
    [string]$labName,
    [string]$subscriptionName = "Cloud Fundamentals Labs"
)

$RESOURCE_GROUP_PREFIX = "CloudFun"

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

# get list of resource groups to delete based on lab name argument
if ($labName) {
    $resourceGroups = az group list --query "[?starts_with(name, '$RESOURCE_GROUP_PREFIX-$labName')].name" -o tsv
} else {
    $resourceGroups = az group list --query "[?starts_with(name, '$RESOURCE_GROUP_PREFIX')].name" -o tsv
}

# Output information about the resource groups to be deleted and ask for confirmation
Write-Host "The following resource groups will be deleted:"
foreach ($rg in $resourceGroups) {
    Write-Host " - $rg"
}
$confirmation = Read-Host "Do you want to proceed with deleting these resource groups? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Host "Resource group deletion cancelled by user."
    exit 0
}

# Delete the resource groups
foreach ($rg in $resourceGroups) {
    Write-Host "Deleting resource group '$rg'..."
    az group delete --name $rg --yes --no-wait
}
