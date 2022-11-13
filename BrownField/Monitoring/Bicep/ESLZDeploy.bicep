targetScope = 'subscription'

@description('The prefix to use on resources inside this template')
@minLength(1)
@maxLength(20)
param Prefix string = 'SJAUETEST1'

@description('Optional: The location the private cloud should be deployed to, by default this will be the location of the deployment')
param Location string = deployment().location

@description('Deploy AVS Dashboard')
param DeployDashboard bool = true

@description('Deploy Azure Monitor metric alerts for your AVS Private Cloud')
param DeployMetricAlerts bool = true

@description('Deploy Service Health Alerts for AVS')
param DeployServiceHealth bool = true

@description('Email addresses to be added to the alerting action group. Use the format ["name1@domain.com","name2@domain.com"].')
param AlertEmails string = 'abc@live.com'


param PrivateCloudName string = 'SJAVSAUE-SDDC'
param PrivateCloudResourceId string = '/subscriptions/3360bc25-f24a-4221-9129-2207e9adb5bc/resourceGroups/SJAVSAUE-PrivateCloud/providers/Microsoft.AVS/privateClouds/SJAVSAUE-SDDC'

@description('Deploy the Workbook for AVS')
param DeployWorkbook bool = true

//Diagnostic Module
param DeployDiagnostics bool = true
param DeployAVSDiagnostics bool = true
param DeployActivityLogDiagnostics bool = true
param EnableLogAnalytics bool = true
param EnableStorageAccount bool = true
param ExistingWorkspaceId string = ''
param ExistingStorageAccountId string = ''
param DeployWorkspace bool = true
param DeployStorageAccount bool = true

var deploymentPrefix = 'AVS-${uniqueString(deployment().name, Location)}'

module OperationalMonitoring 'Modules/Monitoring.bicep' = if ((DeployMetricAlerts) || (DeployServiceHealth) || (DeployDashboard) || (DeployWorkbook)) {
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
    PrivateCloudName: PrivateCloudName
    PrivateCloudResourceId: PrivateCloudResourceId
    DeployAVSDiagnostics: DeployAVSDiagnostics
    DeployActivityLogDiagnostics: DeployActivityLogDiagnostics
    EnableLogAnalytics: EnableLogAnalytics
    EnableStorageAccount: EnableStorageAccount
    ExistingWorkspaceId: ExistingWorkspaceId
    ExistingStorageAccountId: ExistingStorageAccountId
    DeployWorkspace: DeployWorkspace
    DeployStorageAccount: DeployStorageAccount
  }
}

