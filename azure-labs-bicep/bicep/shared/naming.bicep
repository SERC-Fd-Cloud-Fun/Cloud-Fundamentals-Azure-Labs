// naming.bicep – Shared naming-convention module.
// All resource names used across the lab system are derived here so that
// naming is consistent regardless of which main.bicep calls this module.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab01-vm").')
param labId string

@description('Student (or group) identifier (e.g. "student001").')
param studentId string

// ---------------------------------------------------------------------------
// Resource Group
// ---------------------------------------------------------------------------
@description('Name of the per-student lab Resource Group.')
output resourceGroupName string = 'rg-cf-${cohort}-${labId}-${studentId}'

// ---------------------------------------------------------------------------
// Policy definitions
// ---------------------------------------------------------------------------
@description('Name of the "allowed locations" policy definition.')
output policyAllowedLocationsName string = 'pol-cf-${cohort}-${labId}-allowed-locations'

@description('Name of the "allowed resource types" policy definition.')
output policyAllowedResourceTypesName string = 'pol-cf-${cohort}-${labId}-allowed-resource-types'

@description('Name of the "allowed VM SKUs" policy definition (lab01-vm only).')
output policyAllowedVmSkusName string = 'pol-cf-${cohort}-${labId}-allowed-vm-skus'

@description('Name of the "allowed storage SKUs" policy definition (lab02-storage only).')
output policyAllowedStorageSkusName string = 'pol-cf-${cohort}-${labId}-allowed-storage-skus'

@description('Name of the "deny public IP" policy definition (lab03-network only).')
output policyDenyPublicIpName string = 'pol-cf-${cohort}-${labId}-deny-public-ip'

// ---------------------------------------------------------------------------
// Initiative (Policy Set)
// ---------------------------------------------------------------------------
@description('Name of the lab Policy Set (initiative).')
output initiativeName string = 'init-cf-${cohort}-${labId}'

// ---------------------------------------------------------------------------
// Policy assignment
// ---------------------------------------------------------------------------
@description('Name of the policy assignment scoped to the lab Resource Group.')
output policyAssignmentName string = 'asg-cf-${cohort}-${labId}-${studentId}'
