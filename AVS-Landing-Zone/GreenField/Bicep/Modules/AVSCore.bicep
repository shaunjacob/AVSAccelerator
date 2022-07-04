targetScope = 'subscription'

param Location string
param Prefix string
param PrivateCloudAddressSpace string
param PrivateCloudSKU string
param PrivateCloudHostCount int
param TelemetryOptOut bool
param ExistingPrivateCloudId string

var DeployNew = empty(ExistingPrivateCloudId)

resource PrivateCloudResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = if (DeployNew) {
  name: '${Prefix}-PrivateCloud'
  location: Location
}

module PrivateCloud 'AVSCore/PrivateCloud.bicep' = if (DeployNew) {
  scope: PrivateCloudResourceGroup
  name: '${deployment().name}-PrivateCloud'
  params: {
    Prefix: Prefix
    Location: Location
    NetworkBlock: PrivateCloudAddressSpace
    SKUName: PrivateCloudSKU
    ManagementClusterSize: PrivateCloudHostCount
    TelemetryOptOut: TelemetryOptOut
  }
}


output PrivateCloudName string = PrivateCloud.outputs.PrivateCloudName
output PrivateCloudResourceGroupName string = DeployNew ? PrivateCloudResourceGroup.name : split(ExistingPrivateCloudId,'/')[4]
output PrivateCloudResourceId string = PrivateCloud.outputs.PrivateCloudResourceId
