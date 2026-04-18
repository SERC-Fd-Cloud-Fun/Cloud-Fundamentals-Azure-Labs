// lab01-vm/policies.bicepparam
// Policy definitions for Lab 1: Creating Virtual Machines in Azure
using '../shared/policyDefinitions.bicep'

// Policy definition parameters
param allowedResourceTypes = [
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Compute/disks'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/publicIPAddresses'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Compute/sshPublicKeys'
  'Microsoft.Authorization/roleAssignments'
  'Microsoft.Consumption/budgets'
  'Microsoft.Authorization/policies'
  'Microsoft.Authorization/policyAssignments'
  'Microsoft.Network/networkSecurityGroups/securityRules'
]
