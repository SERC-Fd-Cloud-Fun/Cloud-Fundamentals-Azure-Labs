// lab04-webserver/policies.bicepparam
// Policy definitions for Lab 4: Web and Database Servers on Virtual Machines in Azure
using '../shared/policyDefinitions.bicep'

// Lab identifier
param labIdentifier = 'lab04web'

// Policy definition parameters
param allowedResourceTypes = [
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Compute/disks'
  'Microsoft.Compute/sshPublicKeys'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/virtualNetworks/subnets'
  'Microsoft.Network/publicIPAddresses'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Network/networkSecurityGroups/securityRules'
  'Microsoft.Resources/resourceGroups'
]

// Allowed VM sizes for cost control
param allowedVMSizes = [
  'Standard_B1s'
  'Standard_B2s'
  'Standard_B1ms'
  'Standard_B2ms'
  'Standard_B2ats_v2'
]

// Deny high availability features to control costs
param denyHighAvailabilitySets = true

// Optional: Restrict to specific Azure regions
param allowedLocations = []

// Create policy assignments automatically
param createPolicyAssignments = true

// Optional: Require specific tags
param requiredTags = []
