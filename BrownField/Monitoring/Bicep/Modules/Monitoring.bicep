targetScope = 'subscription'

param Prefix string
param PrimaryLocation string
param AlertEmails string
param DeployMetricAlerts bool
param DeployServiceHealth bool
param DeployDashbord bool
param DeployWorkbook bool
param PrivateCloudName string
param PrivateCloudResourceId string

resource OperationalResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Operational'
  location: PrimaryLocation
}

module ActionGroup 'Monitoring/ActionGroup.bicep' = if ((DeployMetricAlerts) || (DeployServiceHealth)) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-ActionGroup'
  params: {
    Prefix: Prefix
    ActionGroupEmails: AlertEmails
  }
}

module PrimaryMetricAlerts 'Monitoring/MetricAlerts.bicep' = if (DeployMetricAlerts) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-MetricAlerts'
  params: {
    ActionGroupResourceId: ActionGroup.outputs.ActionGroupResourceId
    AlertPrefix: PrivateCloudName
    PrivateCloudResourceId: PrivateCloudResourceId
  }
}

module ServiceHealth 'Monitoring/ServiceHealth.bicep' = if (DeployServiceHealth) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-ServiceHealth'
  params: {
    ActionGroupResourceId: ActionGroup.outputs.ActionGroupResourceId
    AlertPrefix: PrivateCloudName
    PrivateCloudResourceId: PrivateCloudResourceId
  }
}

module Dashboard 'Monitoring/Dashboard.bicep' = if (DeployDashbord) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Dashboard'
  params:{
    Location: PrimaryLocation
    PrivateCloudResourceId: PrivateCloudResourceId
    PrivateCloudName: PrivateCloudName
  }
}

module Workbook 'Monitoring/Workbook.bicep' = if (DeployWorkbook) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Workbook'
  params:{
    Location: PrimaryLocation
  }
}

