param Location string
param PrivateCloudName string = ''
param DeployStorageAccount bool
param ExistingStorageAccountId string = ''

var storageaccountname = 'avs${uniqueString(resourceGroup().id)}'

resource PrivateCloud 'Microsoft.AVS/privateClouds@2021-12-01' existing = {
  name: PrivateCloudName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = if (DeployStorageAccount) {
  name: storageaccountname
  location: Location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource StorageAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'Logs-to-StorageAccount'
  scope: PrivateCloud
  properties: {
    storageAccountId: DeployStorageAccount ? storageAccount.id : ExistingStorageAccountId
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

output StorageAccountName string = storageAccount.name
output StorageAccountid string = storageAccount.id
