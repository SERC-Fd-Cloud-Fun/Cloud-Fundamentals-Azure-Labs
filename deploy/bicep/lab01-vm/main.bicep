// lab01-vm/main.bicep
// Bicep template for Lab 1: Creating Virtual Machines in Azure
// Creates resource group for each student with restrictions on resource creation and management.
//
// Deployment scope: subscription
// Deploys
//   - Resource Group with a unique name for each student
//   - Role Assignment to restrict resource management to the student
//   - Policy assignment scoped to the resource group
targetScope = 'subscription' 
