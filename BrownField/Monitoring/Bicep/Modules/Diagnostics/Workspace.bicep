param Prefix string
param Location string
param PrivateCloudName string = ''
param DeployWorkspace bool
param DeployAVSLogsWorkspace bool
param ExistingWorkspaceId string = ''

resource PrivateCloud 'Microsoft.AVS/privateClouds@2021-12-01' existing = {
  name: PrivateCloudName
}

resource Workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = if (DeployWorkspace) {
  name: '${Prefix}-Workspace'
  location: Location
}

resource LogAnalyticsDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (DeployAVSLogsWorkspace) {
  name: 'Logs-to-Workspace'
  scope: PrivateCloud
  properties: {
    workspaceId: DeployWorkspace ? Workspace.id : ExistingWorkspaceId
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'VMwareSyslog'
        enabled: true
      }
    ]
  }
}

output WorkspaceId string = DeployWorkspace ? Workspace.id : ExistingWorkspaceId
