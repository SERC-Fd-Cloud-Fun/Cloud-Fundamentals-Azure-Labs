// allowed-locations.bicep – Policy definition: deny resources outside allowed locations.
// Deployed at subscription scope.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab01-vm").')
param labId string

@description('Default list of allowed Azure locations.')
param allowedLocations array = ['uksouth', 'ukwest']

var policyName = 'pol-cf-${cohort}-${labId}-allowed-locations'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'CF ${cohort} ${labId} – Allowed locations'
    description: 'Denies deployment of resources to Azure locations not in the allowed list.'
    parameters: {
      allowedLocations: {
        type: 'Array'
        defaultValue: allowedLocations
        metadata: {
          displayName: 'Allowed locations'
          description: 'The list of Azure locations where resources can be deployed.'
        }
      }
    }
    policyRule: {
      if: {
        not: {
          field: 'location'
          in: '[parameters(\'allowedLocations\')]'
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
