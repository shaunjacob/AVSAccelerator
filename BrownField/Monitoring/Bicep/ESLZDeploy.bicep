targetScope = 'subscription'

@description('The prefix to use on resources inside this template')
@minLength(1)
@maxLength(20)
param Prefix string = ''

@description('Optional: The location the private cloud should be deployed to, by default this will be the location of the deployment')
param Location string = deployment().location

@description('Deploy AVS Dashboard')
param DeployDashboard bool = true

@description('Deploy Azure Monitor metric alerts for your AVS Private Cloud')
param DeployMetricAlerts bool = false

@description('Deploy Service Health Alerts for AVS')
param DeployServiceHealth bool = false

@description('Deploy the Workbook for AVS')
param DeployWorkbook bool = false

@description('Deploy the Workbook for AVS')
param DeployDiagnostics bool = true
param DeployAVSDiagnostics bool = true
param DeployActivityLogDiagnostics bool = true
param WorkspaceName string = ''

param PrivateCloudName string = ''

param PrivateCloudResourceId string = '/subscriptions/1caa5ab4-523f-4851-952b-1b689c48fae9/resourceGroups/kk-avs-PrivateCloud/providers/Microsoft.AVS/privateClouds/kk-avs-SDDC'

@description('Email addresses to be added to the alerting action group. Use the format ["name1@domain.com","name2@domain.com"].')
param AlertEmails string = ''

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
    WorkspaceName: WorkspaceName
    DeployAVSDiagnostics: DeployAVSDiagnostics
    DeployActivityLogDiagnostics: DeployActivityLogDiagnostics
  }
}

