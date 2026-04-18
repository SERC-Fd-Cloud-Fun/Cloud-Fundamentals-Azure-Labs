// lab01-vm/main.bicep
// Bootstraps the Virtual Machine lab environment for a single student.
//
// Deployment scope: subscription
// Deploys:
//   - Resource Group
//   - Policy definitions: allowed-locations, allowed-resource-types, allowed-vm-skus
//   - Initiative (Policy Set) aggregating all three policies
//   - Policy assignment scoped to the Resource Group
targetScope = 'subscription'

// ---------------------------------------------------------------------------
// Parameters
// ---------------------------------------------------------------------------
@description('Cohort identifier (e.g. "2026").')
param cohort string = '2026'

@description('Student (or group) identifier – used in resource and policy names.')
param studentId string

@description('Primary Azure region for the Resource Group.')
param location string = 'uksouth'

@description('Allowed Azure locations enforced by policy.')
param allowedLocations array = ['uksouth', 'ukwest']

@description('Allowed resource types for the VM lab.')
param allowedResourceTypes array = [
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Compute/disks'
  'Microsoft.Compute/virtualMachineScaleSets'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Storage/storageAccounts'
]

@description('Allowed VM SKU names for the VM lab.')
param allowedVmSkus array = ['Standard_B1s', 'Standard_B2s']

// ---------------------------------------------------------------------------
// Variables – naming convention (mirrors shared/naming.bicep)
// ---------------------------------------------------------------------------
var labId = 'lab01-vm'
var rgName            = 'rg-cf-${cohort}-${labId}-${studentId}'
var initiativeName    = 'init-cf-${cohort}-${labId}'
var assignmentName    = 'asg-cf-${cohort}-${labId}-${studentId}'

// Tags (mirrors shared/tags.bicep)
var tags = {
  module: 'CloudFundamentals'
  cohort: cohort
  labId: labId
  owner: studentId
}

// ---------------------------------------------------------------------------
// Resource Group
// ---------------------------------------------------------------------------
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
  tags: tags
}

// ---------------------------------------------------------------------------
// Policy definitions (subscription scope)
// ---------------------------------------------------------------------------
module allowedLocationsPolicy '../../shared/policies/allowed-locations.bicep' = {
  name: 'deploy-pol-allowed-locations'
  params: {
    cohort: cohort
    labId: labId
    allowedLocations: allowedLocations
  }
}

module allowedResourceTypesPolicy '../../shared/policies/allowed-resource-types.bicep' = {
  name: 'deploy-pol-allowed-resource-types'
  params: {
    cohort: cohort
    labId: labId
    allowedResourceTypes: allowedResourceTypes
  }
}

module allowedVmSkusPolicy '../../shared/policies/allowed-vm-skus.bicep' = {
  name: 'deploy-pol-allowed-vm-skus'
  params: {
    cohort: cohort
    labId: labId
    allowedVmSkus: allowedVmSkus
  }
}

// ---------------------------------------------------------------------------
// Initiative (Policy Set) – subscription scope
// ---------------------------------------------------------------------------
resource initiative 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: initiativeName
  properties: {
    displayName: 'CF ${cohort} ${labId} – Lab Initiative'
    description: 'Governs what students can deploy in the ${labId} lab, cohort ${cohort}.'
    parameters: {
      allowedLocations: {
        type: 'Array'
        defaultValue: allowedLocations
        metadata: {
          displayName: 'Allowed locations'
          description: 'Azure regions where resources may be deployed.'
        }
      }
      allowedResourceTypes: {
        type: 'Array'
        defaultValue: allowedResourceTypes
        metadata: {
          displayName: 'Allowed resource types'
          description: 'Resource types that students are permitted to create.'
        }
      }
      allowedVmSkus: {
        type: 'Array'
        defaultValue: allowedVmSkus
        metadata: {
          displayName: 'Allowed VM SKUs'
          description: 'Virtual Machine sizes that students are permitted to use.'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionId: allowedLocationsPolicy.outputs.policyDefinitionId
        policyDefinitionReferenceId: 'allowed-locations'
        parameters: {
          allowedLocations: {
            value: '[parameters(\'allowedLocations\')]'
          }
        }
      }
      {
        policyDefinitionId: allowedResourceTypesPolicy.outputs.policyDefinitionId
        policyDefinitionReferenceId: 'allowed-resource-types'
        parameters: {
          allowedResourceTypes: {
            value: '[parameters(\'allowedResourceTypes\')]'
          }
        }
      }
      {
        policyDefinitionId: allowedVmSkusPolicy.outputs.policyDefinitionId
        policyDefinitionReferenceId: 'allowed-vm-skus'
        parameters: {
          allowedVmSkus: {
            value: '[parameters(\'allowedVmSkus\')]'
          }
        }
      }
    ]
  }
}

// ---------------------------------------------------------------------------
// Policy assignment – Resource Group scope (via module to satisfy scope rules)
// ---------------------------------------------------------------------------
module policyAssignment '../../shared/policy-assignment.bicep' = {
  name: 'deploy-policy-assignment'
  scope: rg
  params: {
    assignmentName: assignmentName
    displayName: 'CF ${cohort} ${labId} – Initiative for ${studentId}'
    policyDefinitionId: initiative.id
    policyParameters: {
      allowedLocations: {
        value: allowedLocations
      }
      allowedResourceTypes: {
        value: allowedResourceTypes
      }
      allowedVmSkus: {
        value: allowedVmSkus
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Outputs
// ---------------------------------------------------------------------------
@description('Name of the deployed Resource Group.')
output resourceGroupName string = rg.name

@description('Resource ID of the policy initiative.')
output initiativeId string = initiative.id

@description('Resource ID of the policy assignment.')
output policyAssignmentId string = policyAssignment.outputs.policyAssignmentId
