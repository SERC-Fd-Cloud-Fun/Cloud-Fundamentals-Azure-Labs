// allowed-vm-skus.bicep – Policy definition: deny VM SKUs not in the allowed list.
// Applies only to Microsoft.Compute/virtualMachines resources.
// Deployed at subscription scope.
targetScope = 'subscription'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab01-vm").')
param labId string

@description('Default list of allowed VM SKU names.')
param allowedVmSkus array = ['Standard_B1s', 'Standard_B2s']

var policyName = 'pol-cf-${cohort}-${labId}-allowed-vm-skus'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'CF ${cohort} ${labId} – Allowed VM SKUs'
    description: 'Denies deployment of Virtual Machines whose SKU is not in the approved list.'
    parameters: {
      allowedVmSkus: {
        type: 'Array'
        defaultValue: allowedVmSkus
        metadata: {
          displayName: 'Allowed VM SKUs'
          description: 'The list of VM SKU names (sizes) that students are permitted to use.'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            not: {
              field: 'Microsoft.Compute/virtualMachines/sku.name'
              in: '[parameters(\'allowedVmSkus\')]'
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
