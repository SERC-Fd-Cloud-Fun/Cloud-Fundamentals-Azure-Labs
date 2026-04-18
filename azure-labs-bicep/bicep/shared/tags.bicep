// tags.bicep – Shared tags module.
// Returns the standard tag set applied to every lab Resource Group.
targetScope = 'subscription'

@description('Module name tag value (default: CloudFundamentals).')
param moduleName string = 'CloudFundamentals'

@description('Cohort identifier (e.g. "2026").')
param cohort string

@description('Lab identifier (e.g. "lab01-vm").')
param labId string

@description('Student (or group) identifier used as the "owner" tag value.')
param studentId string

@description('Standard tags for the lab Resource Group.')
output tags object = {
  module: moduleName
  cohort: cohort
  labId: labId
  owner: studentId
}
