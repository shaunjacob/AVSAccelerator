param Prefix string = ''
param Location string = resourceGroup().location
param AlertEmails string = ''
param DeployMetricAlerts bool
param DeployServiceHealth bool
param DeployDashboard bool
param DeployWorkbook bool
param PrivateCloudName string = ''
param PrivateCloudResourceId string = ''


module ActionGroup 'Modules/Monitoring/ActionGroup.bicep' = if ((DeployMetricAlerts) || (DeployServiceHealth)) {
  name: '${deployment().name}-ActionGroup'
  params: {
    Prefix: Prefix
    ActionGroupEmails: AlertEmails
  }
}

module PrimaryMetricAlerts 'Modules/Monitoring/MetricAlerts.bicep' = if (DeployMetricAlerts) {
  name: '${deployment().name}-MetricAlerts'
  params: {
    ActionGroupResourceId: ActionGroup.outputs.ActionGroupResourceId
    AlertPrefix: PrivateCloudName
    PrivateCloudResourceId: PrivateCloudResourceId
  }
}

module ServiceHealth 'Modules/Monitoring/ServiceHealth.bicep' = if (DeployServiceHealth) {
  name: '${deployment().name}-ServiceHealth'
  params: {
    ActionGroupResourceId: ActionGroup.outputs.ActionGroupResourceId
    AlertPrefix: PrivateCloudName
    PrivateCloudResourceId: PrivateCloudResourceId
  }
}

module Dashboard 'Modules/Monitoring/Dashboard.bicep' = if (DeployDashboard) {
  name: '${deployment().name}-Dashboard'
  params:{
    Location: Location
    PrivateCloudResourceId: PrivateCloudResourceId
    PrivateCloudName: PrivateCloudName
  }
}

module Workbook 'Modules/Monitoring/Workbook.bicep' = if (DeployWorkbook) {
  name: '${deployment().name}-Workbook'
  params:{
    Location: Location
  }
}

