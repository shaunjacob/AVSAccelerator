param PrivateCloudName string = ''
param Workspaceid string = ''
param StorageAccountid string = ''

param EnableLogAnalytics bool = true
param EnableStorageAccount bool = true


resource PrivateCloud 'Microsoft.AVS/privateClouds@2021-12-01' existing = {
  name: PrivateCloudName
}

resource LogAnalyticsDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && ! (EnableStorageAccount)) {
  name: 'CollectAVSLogs-x62m1'
  scope: PrivateCloud
  properties: {
    workspaceId: Workspaceid
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

resource StorageAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableStorageAccount) && ! (EnableLogAnalytics)) {
  name: 'CollectAVSLogs-awfyp'
  scope: PrivateCloud
  properties: {
    storageAccountId: StorageAccountid
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 1
          enabled: true
        }
      }
    ]
    logs: [
      {
        category: 'VMwareSyslog'
        enabled: true
        retentionPolicy: {
          days: 1
          enabled: true
        }
      }
    ]
  }
}

resource AllDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && (EnableStorageAccount)) {
  name: 'CollectAVSLogs'
  scope: PrivateCloud
  properties: {
    workspaceId: Workspaceid
    storageAccountId: StorageAccountid
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy:{
          days: 1
          enabled: true
        }
      }
    ]
    logs: [
      {
        category: 'VMwareSyslog'
        enabled: true
        retentionPolicy:{
          days: 1
          enabled: true
        }
      }
    ]
  }
}
