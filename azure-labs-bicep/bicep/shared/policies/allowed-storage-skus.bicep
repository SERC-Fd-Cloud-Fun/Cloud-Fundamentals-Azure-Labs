// allowed-storage-skus.bicep – Policy definition: deny Storage Account SKUs not in the allowed list.
// Applies only to Microsoft.Storage/storageAccounts resources.
// Deployed at subscription scope.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab02-storage").')
param labId string

@description('Default list of allowed Storage Account SKU names.')
param allowedStorageSkus array = ['Standard_LRS', 'Standard_GRS']

var policyName = 'pol-cf-${cohort}-${labId}-allowed-storage-skus'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'CF ${cohort} ${labId} – Allowed storage SKUs'
    description: 'Denies deployment of Storage Accounts whose SKU is not in the approved list.'
    parameters: {
      allowedStorageSkus: {
        type: 'Array'
        defaultValue: allowedStorageSkus
        metadata: {
          displayName: 'Allowed storage SKUs'
          description: 'The list of Storage Account SKU names that students are permitted to use.'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            not: {
              field: 'Microsoft.Storage/storageAccounts/sku.name'
              in: '[parameters(\'allowedStorageSkus\')]'
            }
          }
        ]
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
