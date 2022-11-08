param PrivateCloudName string = 'SJAVSAUE-SDDC'
param Workspaceid string = '/subscriptions/3360bc25-f24a-4221-9129-2207e9adb5bc/resourceGroups/SJAVSAUE-PrivateCloud/providers/Microsoft.OperationalInsights/workspaces/sjtestlga001'
param StorageAccountid string = '/subscriptions/3360bc25-f24a-4221-9129-2207e9adb5bc/resourceGroups/storage-rg/providers/Microsoft.Storage/storageAccounts/sjavsstorage'
param eventHubAuthorizationRuleId string = '/subscriptions/3360bc25-f24a-4221-9129-2207e9adb5bc/resourcegroups/SJAVSAUE-PrivateCloud/providers/Microsoft.EventHub/namespaces/sjeventhubtest01/authorizationrules/RootManageSharedAccessKey'

param EnableLogAnalytics bool = true
param EnableStorageAccount bool = true
param EnableEventHub bool = false

resource PrivateCloud 'Microsoft.AVS/privateClouds@2021-12-01' existing = {
  name: PrivateCloudName
}

resource LogAnalyticsDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && ! (EnableStorageAccount) && ! (EnableEventHub)) {
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

resource StorageAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableStorageAccount) && ! (EnableLogAnalytics) && ! (EnableEventHub)) {
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

resource EventHubDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableEventHub) && ! (EnableStorageAccount) && ! (EnableLogAnalytics)) {
  name: 'CollectAVSLogs-95lkw'
  scope: PrivateCloud
  properties: {
    eventHubAuthorizationRuleId: eventHubAuthorizationRuleId
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

resource AllDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && (EnableStorageAccount) && (EnableEventHub)) {
  name: 'CollectAVSLogs2'
  scope: PrivateCloud
  properties: {
    workspaceId: Workspaceid
    eventHubAuthorizationRuleId: eventHubAuthorizationRuleId
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

resource LGASTA 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && (EnableStorageAccount) && ! (EnableEventHub)) {
  name: 'CollectAVSLogs-mn6m8'
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

resource LGAEVH 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableLogAnalytics) && (EnableEventHub) && ! (EnableStorageAccount)) {
  name: 'CollectAVSLogs-dxjec'
  scope: PrivateCloud
  properties: {
    workspaceId: Workspaceid
    eventHubAuthorizationRuleId: eventHubAuthorizationRuleId
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

resource STAEVH 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if ((EnableStorageAccount) && (EnableEventHub) && ! (EnableLogAnalytics)) {
  name: 'CollectAVSLogs-vz734'
  scope: PrivateCloud
  properties: {
    eventHubAuthorizationRuleId: eventHubAuthorizationRuleId
    storageAccountId: StorageAccountid
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
        retentionPolicy:{
          days: 1
          enabled: true
        }
      }
    ]
  }
}
