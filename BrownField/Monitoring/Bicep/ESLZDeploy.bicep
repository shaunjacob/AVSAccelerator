targetScope = 'subscription'

@description('The prefix to use on resources inside this template')
@minLength(1)
@maxLength(20)
param Prefix string = ''

@description('Optional: The location the private cloud should be deployed to, by default this will be the location of the deployment')
param Location string = deployment().location

@description('Deploy AVS Monitoring')
param DeployMonitoring bool = false

@description('Deploy AVS Dashboard')
param DeployDashboard bool = false

@description('Deploy Azure Monitor metric alerts for your AVS Private Cloud')
param DeployMetricAlerts bool = false

@description('Deploy Service Health Alerts for AVS')
param DeployServiceHealth bool = false

@description('Email addresses to be added to the alerting action group. Use the format ["name1@domain.com","name2@domain.com"].')
param AlertEmails string = ''


param PrivateCloudName string = ''
param PrivateCloudResourceId string = ''

@description('Deploy the Workbook for AVS')
param DeployWorkbook bool = false

//Diagnostic Module
param DeployDiagnostics bool = false
param DeployAVSLogsWorkspace bool = false
param DeployActivityLogDiagnostics bool = false
param DeployAVSLogsStorage bool = false
param ExistingWorkspaceId string = ''
param ExistingStorageAccountId string = ''
param DeployWorkspace bool = false
param DeployStorageAccount bool = false
param DiagnosticsPrivateCloudName string = ''
param DiagnosticsPrivateCloudResourceId string = ''


var deploymentPrefix = 'AVS-${uniqueString(deployment().name, Location)}'

module OperationalMonitoring 'Modules/Monitoring.bicep' = if ((DeployMonitoring)) {
  name: '${deploymentPrefix}-Monitoring'
  params: {
    AlertEmails: AlertEmails
    Prefix: Prefix
    PrimaryLocation: Location
    DeployMetricAlerts : DeployMetricAlerts
    DeployServiceHealth : DeployServiceHealth
    DeployDashboard : DeployDashboard
    DeployWorkbook : DeployWorkbook
    PrivateCloudName : PrivateCloudName
    PrivateCloudResourceId : PrivateCloudResourceId
  }
}

module Diagnostics 'Modules/Diagnostics.bicep' = if ((DeployDiagnostics)) {
  name: '${deploymentPrefix}-Diagnostics'
  params: {
    Location: Location
    Prefix: Prefix
    PrivateCloudName: DiagnosticsPrivateCloudName
    PrivateCloudResourceId: DiagnosticsPrivateCloudResourceId
    DeployAVSLogsWorkspace: DeployAVSLogsWorkspace
    DeployActivityLogDiagnostics: DeployActivityLogDiagnostics
    DeployAVSLogsStorage: DeployAVSLogsStorage
    ExistingWorkspaceId: ExistingWorkspaceId
    ExistingStorageAccountId: ExistingStorageAccountId
    DeployWorkspace: DeployWorkspace
    DeployStorageAccount: DeployStorageAccount
  }
}

