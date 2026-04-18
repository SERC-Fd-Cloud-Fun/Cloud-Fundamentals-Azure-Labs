// policy-assignment.bicep – Deploys a policy assignment at Resource Group scope.
// This module is deployed from subscription-scoped lab templates using `scope: rg`
// so that the assignment is scoped to (and enforced within) the lab Resource Group.
targetScope = 'resourceGroup'

@description('Policy assignment name (max 128 characters).')
param assignmentName string

@description('Human-readable display name for the assignment.')
param displayName string

@description('Resource ID of the initiative (policy set definition) to assign.')
param policyDefinitionId string

@description('Parameter values to pass to the initiative.')
param policyParameters object = {}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: assignmentName
  properties: {
    displayName: displayName
    policyDefinitionId: policyDefinitionId
    parameters: policyParameters
  }
}

@description('Resource ID of the policy assignment.')
output policyAssignmentId string = policyAssignment.id
