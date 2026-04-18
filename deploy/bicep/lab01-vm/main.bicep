// lab01-vm/main.bicep
// Bicep template for Lab 1: Creating Virtual Machines in Azure
// Creates resource group for each student with restrictions on resource creation and management.
//
// Deployment scope: subscription
// Deploys
//   - Resource Group with a unique name for each student
//   - Role Assignment to restrict resource management to the student
//   - Policy assignment scoped to the resource group
//   - Budget scoped to the resource group
targetScope = 'subscription'

@description('The name of the student.')
param studentName string

@description('The student ID used for naming resources.')
param studentID string

@description('The Azure AD Object ID of the student, used for RBAC assignment.')
param studentObjectID string

@description('The name of the resource group to create for the student.')
param resourceGroupName string

@description('The Azure region to deploy resources into.')
param location string = 'uksouth'

// Role definition ID for the built-in Contributor role
var contributorRoleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')

// Create a resource group for the student
resource studentResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    student: studentName
    studentID: studentID
    lab: 'lab01-vm'
  }
}

// Assign the Contributor role to the student on their resource group
resource contributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(studentResourceGroup.id, studentObjectID, contributorRoleDefinitionId)
  scope: studentResourceGroup
  properties: {
    roleDefinitionId: contributorRoleDefinitionId
    principalId: studentObjectID
    principalType: 'User'
  }
}

// Deploy the budget at resource group scope via a module
module studentBudget './budget.bicep' = {
  name: 'budget-${studentID}'
  scope: studentResourceGroup
  params: {
    studentID: studentID
  }
}

