param storageaccountName string = ''
param Location string


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageaccountName
  location: Location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    dnsEndpointType: 'string'
  }
}

output StorageAccountName string = storageAccount.name
output StorageAccountid string = storageAccount.id
