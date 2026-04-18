// allowed-resource-types.bicep – Policy definition: deny resource types not in the allowed list.
// Deployed at subscription scope.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab01-vm").')
param labId string

@description('List of allowed resource types (must be provided by the caller).')
param allowedResourceTypes array

var policyName = 'pol-cf-${cohort}-${labId}-allowed-resource-types'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'CF ${cohort} ${labId} – Allowed resource types'
    description: 'Denies deployment of resource types not in the approved list for this lab.'
    parameters: {
      allowedResourceTypes: {
        type: 'Array'
        defaultValue: allowedResourceTypes
        metadata: {
          displayName: 'Allowed resource types'
          description: 'The list of resource types that can be deployed in this lab.'
        }
      }
    }
    policyRule: {
      if: {
        not: {
          field: 'type'
          in: '[parameters(\'allowedResourceTypes\')]'
        }
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}

@description('Resource ID of the policy definition.')
output policyDefinitionId string = policyDef.id

@description('Name of the policy definition.')
output policyDefinitionName string = policyName
