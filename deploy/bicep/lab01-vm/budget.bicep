// lab01-vm/budget.bicep
// Budget module for Lab 1: Creating Virtual Machines in Azure
// Deploys a £10 monthly budget scoped to the student resource group.
targetScope = 'resourceGroup'

@description('The student ID used for naming the budget.')
param studentID string

@description('Email addresses to notify when budget thresholds are reached.')
param contactEmails array = []

@description('The start date of the budget (first day of a month, e.g. 2025-09-01). Defaults to the first day of the current month.')
param budgetStartDate string = utcNow('yyyy-MM-01')

resource studentBudget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: 'student-budget-${studentID}'
  properties: {
    category: 'Cost'
    amount: 10
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: budgetStartDate
    }
    filter: {}
    notifications: {
      notificationAt80Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 80
        contactEmails: contactEmails
        thresholdType: 'Actual'
      }
      notificationAt100Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 100
        contactEmails: contactEmails
        thresholdType: 'Actual'
      }
    }
  }
}
