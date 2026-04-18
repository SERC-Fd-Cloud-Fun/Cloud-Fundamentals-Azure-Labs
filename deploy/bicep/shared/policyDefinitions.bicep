// Policy definitions for Azure Labs
// This file contains reusable policy definitions for the Azure Labs deployment.
targetScope = 'subscription'

@description('List of allowed Azure resource types for this lab.')
param allowedResourceTypes array = []

resource allowedResourceTypesPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'allowed-resource-types'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Allowed resource types'
    description: 'Restricts the resource types that can be deployed in this lab.'
    policyRule: {
      if: {
        not: {
          field: 'type'
          in: allowedResourceTypes
        }
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
