targetScope = 'subscription'

param Location string = 'Southeast Asia'
param Prefix string = 'SJRSTEST'
param NewNetworkResourceGroupName string = 'SJRSTEST'
param NewVNetAddressSpace string = '10.10.0.0/24'
param NewVnetNewGatewaySubnetAddressPrefix string = '10.10.0.0/27'
param DeployRouteServer bool = true
param RouteServerSubnetExists bool = false
param RouteServerSubnetPrefix string = '10.10.0.64/26'

resource NewNetworkResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: NewNetworkResourceGroupName
  location: Location
}

module NewVNetVPNGW 'VPNGateway/NewVNetVPNGW.bicep' = {
  scope: NewNetworkResourceGroup
  name: '${deployment().name}-NewNetwork'
  params: {
    Prefix: Prefix
    Location: Location
    NewVNetAddressSpace: NewVNetAddressSpace
    NewVnetNewGatewaySubnetAddressPrefix: NewVnetNewGatewaySubnetAddressPrefix
  }
}

module RouteServer 'RouteServer/RouteServer.bicep' = if (DeployRouteServer) {
  scope: NewNetworkResourceGroup
  name: '${deployment().name}-RouteServer'
  params: {
    Prefix: Prefix
    Location: Location
    VNetName: NewVNetVPNGW.outputs.VNetName
    RouteServerSubnetPrefix : RouteServerSubnetPrefix
    RouteServerSubnetExists : RouteServerSubnetExists
  }
}


output RouteServer string = RouteServer.outputs.RouteServer
output RouteServerSubnetId string = RouteServer.outputs.NewRouteServerSubnetId
output ExistingRouteServerSubnetId string = RouteServerSubnetExists ? RouteServer.outputs.ExistingRouteServerSubnetId : ''
output NetworkResourceGroup string = NewNetworkResourceGroup.name
