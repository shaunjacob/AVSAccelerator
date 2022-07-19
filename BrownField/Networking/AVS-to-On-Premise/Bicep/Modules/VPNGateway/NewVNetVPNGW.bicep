
param Location string = 'Southeast Asia'
param Prefix string = 'SJRS'
param NewVNetAddressSpace string = '10.10.0.0/24'
param NewVnetNewGatewaySubnetAddressPrefix string = '10.10.0.0/27'
param NewGatewaySku string = 'VpnGw2'

var NewVNetName = '${Prefix}-vnet'
var NewVnetNewGatewayName = '${Prefix}-vpngw'

//New VNet Workflow
resource NewVNet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: NewVNetName
  location: Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        NewVNetAddressSpace
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: NewVnetNewGatewaySubnetAddressPrefix
      }
    }
    ]
  }
}

resource NewGatewayPIP1 'Microsoft.Network/publicIPAddresses@2021-08-01' = {
  name: '${NewVnetNewGatewayName}-pip1'
  location: Location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource NewGatewayPIP2 'Microsoft.Network/publicIPAddresses@2021-08-01' = {
  name: '${NewVnetNewGatewayName}-pip2'
  location: Location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

//New Gateway Workflow
resource NewVnetNewGateway 'Microsoft.Network/virtualNetworkGateways@2021-08-01' = {
  name: NewVnetNewGatewayName
  location: Location
  properties: {
    activeActive: true
    vpnType: 'RouteBased'
    gatewayType: 'VPN'
    sku: {
      name: NewGatewaySku
      tier: NewGatewaySku
    }
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: NewVNet.properties.subnets[0].id
          }
          publicIPAddress: {
            id: NewGatewayPIP1.id
          }
        }
      }
      {
        name: 'activeActive'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: NewVNet.properties.subnets[0].id
          }
          publicIPAddress: {
            id: NewGatewayPIP2.id
          }
        }
      }
    ]
  }
}

output VNetName string = NewVNet.name
output GatewayName string = NewVnetNewGateway.name
output VNetResourceId string = NewVNet.id
