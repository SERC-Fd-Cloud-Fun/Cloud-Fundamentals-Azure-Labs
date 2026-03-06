# functions to help with Azure PowerShell operations

# check az cli is installed
function Test-AzCliInstalled {
    if (-Not (Get-Command "az" -ErrorAction SilentlyContinue)) {
        Write-Error "Azure CLI is not installed. Please install Azure CLI to use this deployment script."
        exit 1
    }
}

# Check if user is logged in to optional correct tenant
# If not logged in, log them in
function Confirm-AzureLogin {
    param (
        [string]$tenantId = $null
    )
    try {
        $accountInfo = az account show --query "{tenantId: tenantId}" -o json | ConvertFrom-Json
        if ($tenantId -and $accountInfo.tenantId -ne $tenantId) {
            write-host "Current tenant ID '$($accountInfo.tenantId)' does not match the specified tenant ID '$tenantId'. Please log in to the correct tenant."
            az login --tenant $tenantId
        } else {
            write-host "Already logged in to Azure with tenant ID '$($accountInfo.tenantId)'."
        }
    }
    catch {
        write-host "Not logged in to Azure. Please log in to Azure to continue."
        az login $(if ($tenantId) { "--tenant $tenantId" })
    }
}

# Set subscription context
function Set-SubscriptionContext {
    param (
        [string]$subscriptionID
    )
    try {
        Write-Host "Setting Azure subscription context to subscription ID '$subscriptionID'..."
        az account set --subscription $subscriptionID
    } catch {
        Write-Error "Failed to set Azure subscription context. Please ensure the subscription ID is correct and you have access to it."
        exit 1
    }
}

# Get subscription ID from the given subscription name
function Get-SubscriptionID {
    param (
        [string]$subscriptionName
    )
    try {
        $subscriptionId = az account list --query "[?name=='$subscriptionName'].id" -o tsv
        Write-Host "Found subscription ID '$subscriptionId' for subscription name '$subscriptionName'."
        return $subscriptionId
    } catch {
        Write-Error "Failed to get subscription ID. Please ensure the subscription name is correct and you have access to it."
        return $null
    }
}

# Automatically check when the module is loaded
Test-AzCliInstalled
