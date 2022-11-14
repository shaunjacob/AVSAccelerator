targetScope = 'subscription'

param Location string = ''
param Prefix string = ''
param PrivateCloudName string = ''
param PrivateCloudResourceId string = ''
param DeployAVSDiagnostics bool = false
param DeployActivityLogDiagnostics bool = false
param EnableLogAnalytics bool = false
param EnableStorageAccount bool = false
param ExistingWorkspaceId string
param ExistingStorageAccountId string
param DeployWorkspace bool
param DeployStorageAccount bool


var PrivateCloudResourceGroupName = split(PrivateCloudResourceId,'/')[4]

resource OperationalResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Operational'
  location: Location
}

resource PrivateCloudResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: PrivateCloudResourceGroupName
}

module Workspace 'Diagnostics/Workspace.bicep' = if (DeployWorkspace) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Workspace'
  params: {
    Location: Location
    Prefix: Prefix
  }
}

module Storage 'Diagnostics/Storage.bicep' = {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Storage'
  params: {
    Location: Location
  }
}

module AVSDiagnostics 'Diagnostics/AVSDiagnostics.bicep' = if (DeployAVSDiagnostics) {
  scope: PrivateCloudResourceGroup
  name: '${deployment().name}-AVSDiagnostics'
  params: {
    PrivateCloudName: PrivateCloudName
    Workspaceid: DeployWorkspace ? Workspace.outputs.WorkspaceId : ExistingWorkspaceId
    StorageAccountid : DeployStorageAccount ? Storage.outputs.StorageAccountid : ExistingStorageAccountId
    EnableLogAnalytics : EnableLogAnalytics
    EnableStorageAccount : EnableStorageAccount
  }
}

module ActivityLogDiagnostics 'Diagnostics/ActivityLogDiagnostics.bicep' = if (DeployActivityLogDiagnostics) {
  name: '${deployment().name}-ActivityLogDiagnostics'
  params: {
    WorkspaceId: Workspace.outputs.WorkspaceId
  }
}
