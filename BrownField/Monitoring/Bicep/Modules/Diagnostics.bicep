targetScope = 'subscription'

param Location string = 'australiaeast'
param Prefix string = 'sjavs'
param PrivateCloudName string = 'SJAVSAUE-SDDC'
param PrivateCloudResourceId string = '/subscriptions/3360bc25-f24a-4221-9129-2207e9adb5bc/resourceGroups/SJAVSAUE-PrivateCloud/providers/Microsoft.AVS/privateClouds/SJAVSAUE-SDDC'
param DeployAVSDiagnostics bool = true
param DeployActivityLogDiagnostics bool = true
param EnableLogAnalytics bool = true
param EnableStorageAccount bool = true
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
