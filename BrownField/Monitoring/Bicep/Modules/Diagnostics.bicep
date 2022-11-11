targetScope = 'subscription'

param Location string = ''
param Prefix string = ''
param PrivateCloudName string = ''
param PrivateCloudResourceId string = ''
param WorkspaceName string = ''
param DeployAVSDiagnostics bool
param DeployActivityLogDiagnostics bool
param EnableLogAnalytics bool
param EnableStorageAccount bool
param storageaccountName string = ''


var PrivateCloudResourceGroupName = split(PrivateCloudResourceId,'/')[4]

resource OperationalResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Operational'
  location: Location
}

resource PrivateCloudResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: PrivateCloudResourceGroupName
}

module Workspace 'Diagnostics/Workspace.bicep' = {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Workspace'
  params: {
    WorkspaceName: WorkspaceName
    Location: Location
  }
}

module Storage 'Diagnostics/Storage.bicep' = {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Storage'
  params: {
    storageaccountName: storageaccountName
    Location: Location
  }
}

module AVSDiagnostics 'Diagnostics/AVSDiagnostics.bicep' = if (DeployAVSDiagnostics) {
  scope: PrivateCloudResourceGroup
  name: '${deployment().name}-AVSDiagnostics'
  params: {
    PrivateCloudName: PrivateCloudName
    Workspaceid: Workspace.outputs.WorkspaceId
    StorageAccountid : Storage.outputs.StorageAccountid
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
