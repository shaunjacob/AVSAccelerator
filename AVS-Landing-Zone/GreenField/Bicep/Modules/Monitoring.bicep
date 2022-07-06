targetScope = 'subscription'

param DeployMetricAlerts bool
param DeployServiceHealth bool
param DeployDashboard bool
param Prefix string
param PrimaryLocation string
param AlertEmails string
param PrimaryPrivateCloudName string
param PrimaryPrivateCloudResourceId string
param JumpboxResourceId string
param VNetResourceId string
param ExRConnectionResourceId string

resource OperationalResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Operational'
  location: PrimaryLocation
}

module Dashboard 'Monitoring/Dashboard.bicep' = if (DeployDashboard) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Dashboard'
  params:{
    Prefix: Prefix
    Location: PrimaryLocation
    PrivateCloudResourceId: PrimaryPrivateCloudResourceId
    JumpboxResourceId: JumpboxResourceId
    ExRConnectionResourceId: ExRConnectionResourceId
    VNetResourceId: VNetResourceId
  }
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
    AlertPrefix: PrimaryPrivateCloudName
    PrivateCloudResourceId: PrimaryPrivateCloudResourceId
  }
}

module ServiceHealth 'Monitoring/ServiceHealth.bicep' = if (DeployServiceHealth) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-ServiceHealth'
  params: {
    ActionGroupResourceId: ActionGroup.outputs.ActionGroupResourceId
    AlertPrefix: PrimaryPrivateCloudName
    PrivateCloudResourceId: PrimaryPrivateCloudResourceId
  }
}

