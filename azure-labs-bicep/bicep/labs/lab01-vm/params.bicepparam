// lab01-vm/params.bicepparam
// Default parameter values for the lab01-vm deployment.
// Override studentId (and any other values) before deploying.
using './main.bicep'

param cohort = '2026'
param studentId = 'student001'
param location = 'uksouth'
param allowedLocations = ['uksouth', 'ukwest']
param allowedResourceTypes = [
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Compute/disks'
  'Microsoft.Compute/virtualMachineScaleSets'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Storage/storageAccounts'
]
param allowedVmSkus = ['Standard_B1s', 'Standard_B2s']
