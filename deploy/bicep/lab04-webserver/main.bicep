// lab04-webserver/main.bicep
// Bicep template for Lab 4: Web and Database Servers on Virtual Machines in Azure
// Creates virtual machines for web and database servers with necessary configurations.
//
// Deployment scope: subscription
// Deploys
//   - Resource Group with a unique name for each student
//   - Role Assignment to restrict resource management to the student
//   - Policy assignment scoped to the resource group
targetScope = 'subscription' 
