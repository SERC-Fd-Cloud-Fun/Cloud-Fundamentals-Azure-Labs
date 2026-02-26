// lab03-network/params.bicepparam
// Default parameter values for the lab03-network deployment.
// Override studentId (and any other values) before deploying.
using './main.bicep'

param cohort = '2026'
param studentId = 'student001'
param location = 'uksouth'
param allowedLocations = ['uksouth', 'ukwest']
param allowedResourceTypes = [
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/routeTables'
  'Microsoft.Network/loadBalancers'
  'Microsoft.Network/applicationGateways'
]
