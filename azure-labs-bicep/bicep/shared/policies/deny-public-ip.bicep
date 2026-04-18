// deny-public-ip.bicep – Policy definition: deny all Microsoft.Network/publicIPAddresses resources.
// Deployed at subscription scope.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab03-network").')
param labId string

var policyName = 'pol-cf-${cohort}-${labId}-deny-public-ip'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'CF ${cohort} ${labId} – Deny public IP addresses'
    description: 'Denies the creation of Microsoft.Network/publicIPAddresses resources to prevent direct internet exposure.'
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Network/publicIPAddresses'
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
