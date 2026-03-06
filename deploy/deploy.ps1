# PowerShell script to deploy resources for Azure Labs

# arguments for deployment script
# - lab name (e.g. lab01-vm, lab02-storage, lab03-networking)
# - student list CSV file (e.g. students.csv) [optional]
# - subscription name (optional, default is "Cloud Fundamentals Labs")
param (
    [string]$labName,
    [string]$studentListPath = ".\students.csv",
    [string]$subscriptionName = "Cloud Fundamentals Labs"
)

$RESOURCE_GROUP_PREFIX = "CloudFun"

# Check if azure CLI is installed
if (-Not (Get-Command "az" -ErrorAction SilentlyContinue)) {
    Write-Error "Azure CLI is not installed. Please install Azure CLI to use this deployment script."
    exit 1
}

# Check if the lab name argument is provided
if (-Not $labName) {
    Write-Error "Please provide the lab name as an argument. Example: .\deploy.ps1 -labName lab01-vm"
    exit 1
}

# Check if lab name is valid (you can add more lab names as needed)
. .\lib\LabNameFunctions.ps1
if (-Not (Test-LabName -labName $labName)) {
    exit 1
}

# Import the function to parse the student list
. .\lib\Import-StudentList.ps1
$students = ConvertFrom-StudentList -csvFilePath $studentListPath

# Check if the student list was successfully parsed
if ($null -eq $students) {
    Write-Error "Failed to parse student list. Exiting deployment script."
    exit 1
}

# Get subscription id
try {
    Write-Host "Getting subscription ID for subscription name '$subscriptionName'..."
    $subscriptionId = az account list --query "[?name=='$subscriptionName'].id" -o tsv
} catch {
    Write-Error "Failed to get subscription ID. Please ensure the subscription name is correct and you have access to it."
    exit 1
}

# Set the Azure subscription context
try {
    Write-Host "Setting Azure subscription context..."
    az account set --subscription $subscriptionId
} catch {
    Write-Error "Failed to set Azure subscription context. Please ensure the subscription name is correct and you have access to it."
    exit 1
}

# Deploy


# Output deployment information and ask for confirmation before proceeding
# Lab name, number of students, subscription name, and resource group name prefix
Write-Host "================================"
Write-Host " Azure Labs Deployment Summary"
Write-Host "================================"
Write-Host " Lab Name:              $labName"
Write-Host " Number of Students:    $($students.Count)"
Write-Host " Subscription Name:     $subscriptionName"
Write-Host " Subscription ID:       $subscriptionId"
Write-Host " Resource Group Prefix: $RESOURCE_GROUP_PREFIX-$labName-<studentID>"
Write-Host "================================"
$confirmation = Read-Host "Do you want to proceed with the deployment? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Host "Deployment cancelled by user."
    exit 0
}

# deploy policy definitions and initiatives (if any) to the subscription


# Loop through each student and output their information (for demonstration purposes)
foreach ($student in $students) {
    Write-Host "Deploying resources for student: $($student.Name) (ID: $($student.StudentID), ObjectID: $($student.ObjectID))"


    $DEPLOYMENT_NAME = "deploy-cloudfun-$($labName)-$($student.StudentID)-$(Get-Date -Format "yyyyMMddHHmmss")"
    
    # Here you would add the code to deploy resources for each student using their ObjectID
    # For example, you could use Azure CLI or Azure PowerShell commands to create resources in Azure
    # Example (pseudo-code):
    # az deployment group create --resource-group myResourceGroup --template-file main.bicep --parameters studentObjectId=$($student.ObjectID)
}