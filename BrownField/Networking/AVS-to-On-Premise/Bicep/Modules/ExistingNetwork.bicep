targetScope = 'subscription'

param Location string
param Prefix string
param ExistingVNetName string
param RouteServerSubnetPrefix string
param RouteServerSubnetExists bool

resource NetworkResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Network'
  location: Location
}

module ExistingNetwork 'VPNGateway/NewVNetVPNGW.bicep' = if (!VNetExists) {
  scope: NetworkResourceGroup
  name: '${deployment().name}-ExistingNetwork'
  params: {
    Prefix: Prefix
    Location: Location
    NewVNetAddressSpace: NewVNetAddressSpace
    NewVnetNewGatewaySubnetAddressPrefix: NewVnetNewGatewaySubnetAddressPrefix
  }
}

module VPNGateway 'VPNGateway/ExistingVNetVPNGW.bicep' = if (VNetExists) {
  scope: NetworkResourceGroup
  name: '${deployment().name}-ExistingNetwork'
  {
    Prefix: Prefix
    Location: Location
    GatewayExists: GatewayExists
    GatewaySubnetExists: GatewaySubnetExists
    ExistingVnetName: ExistingVnetName
    ExistingGatewayName: ExistingGatewayName
    ExistingGatewaySubnetId: ExistingGatewaySubnetId
    ExistingVnetNewGatewaySubnetPrefix: ExistingVnetNewGatewaySubnetPrefix
  }
}

module RouteServer 'RouteServer/RouteServer.bicep' = if (DeployRouteServer) {
  scope: NetworkResourceGroup
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
output ExistingRouteServerSubnetId string = RouteServer.outputs.ExistingRouteServerSubnetId
output NetworkResourceGroup string = NetworkResourceGroup.name
