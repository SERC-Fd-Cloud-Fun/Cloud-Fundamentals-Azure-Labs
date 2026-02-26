// lab02-storage/params.bicepparam
// Default parameter values for the lab02-storage deployment.
// Override studentId (and any other values) before deploying.
using './main.bicep'

param cohort = '2026'
param studentId = 'student001'
param location = 'uksouth'
param allowedLocations = ['uksouth', 'ukwest']
param allowedResourceTypes = [
  'Microsoft.Storage/storageAccounts'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/privateEndpoints'
  'Microsoft.Network/networkSecurityGroups'
]
param allowedStorageSkus = ['Standard_LRS', 'Standard_GRS']
