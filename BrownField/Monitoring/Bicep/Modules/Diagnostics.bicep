targetScope = 'subscription'

param Location string = ''
param Prefix string = ''
param PrivateCloudName string = ''
//param PrivateCloudResourceId string = ''
param DeployAVSLogsWorkspace bool = false
param DeployActivityLogDiagnostics bool = false
param DeployAVSLogsStorage bool = false
param ExistingWorkspaceId string
param ExistingStorageAccountId string
param DeployWorkspace bool
param DeployStorageAccount bool


//var PrivateCloudResourceGroupName = split(PrivateCloudResourceId,'/')[4]

resource OperationalResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Operational'
  location: Location
}

// resource PrivateCloudResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
//   name: PrivateCloudResourceGroupName
// }

module Workspace 'Diagnostics/Workspace.bicep' = if ((DeployAVSLogsWorkspace) || (DeployWorkspace)) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Workspace'
  params: {
    Location: Location
    Prefix: Prefix
    PrivateCloudName: PrivateCloudName
    DeployAVSLogsWorkspace: DeployAVSLogsWorkspace
    DeployWorkspace: DeployWorkspace
    ExistingWorkspaceId: ExistingWorkspaceId
  }
}

module Storage 'Diagnostics/Storage.bicep' = if (DeployAVSLogsStorage) {
  scope: OperationalResourceGroup
  name: '${deployment().name}-Storage'
  params: {
    Location: Location
    PrivateCloudName: PrivateCloudName
    DeployStorageAccount: DeployStorageAccount
    ExistingStorageAccountId: ExistingStorageAccountId
  }
}


module ActivityLogDiagnostics 'Diagnostics/ActivityLogDiagnostics.bicep' = if (DeployActivityLogDiagnostics) {
  name: '${deployment().name}-ActivityLogDiagnostics'
  params: {
    WorkspaceId: DeployWorkspace ? Workspace.outputs.WorkspaceId : ExistingWorkspaceId
  }
}
