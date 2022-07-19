//Bool
param GatewayExists bool
param GatewaySubnetExists bool

//String
param Location string
param Prefix string
param ExistingVnetName string
param ExistingGatewayName string
param NewGatewaySku string = 'Standard'
param ExistingGatewaySubnetId string
param ExistingVnetNewGatewaySubnetPrefix string

var ExistingVnetNewGatewayName = '${Prefix}-vpngw'

// Existing VNet Workflow
resource ExistingVNet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: ExistingVnetName
}

//Existing Gateway
resource ExistingGateway 'Microsoft.Network/virtualNetworkGateways@2021-08-01' existing = if (GatewayExists) {
  name: ExistingGatewayName
}

// If VNet exists, but GatewaySubnet does not. Create new GatewaySubnet
resource ExistingVnetNewGatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = if (!GatewaySubnetExists) {
  name: 'GatewaySubnet'
  parent: ExistingVNet
  properties: {
    addressPrefix: ExistingVnetNewGatewaySubnetPrefix
  }
}

resource NewGatewayPIP1 'Microsoft.Network/publicIPAddresses@2021-08-01' = if (!GatewayExists) {
  name: '${ExistingVnetNewGatewayName}-pip1'
  location: Location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource NewGatewayPIP2 'Microsoft.Network/publicIPAddresses@2021-08-01' = if (!GatewayExists) {
  name: '${ExistingVnetNewGatewayName}-pip2'
  location: Location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource ExistingVnetNewGateway 'Microsoft.Network/virtualNetworkGateways@2021-08-01' = if (!GatewayExists) {
  name: ExistingVnetNewGatewayName
  location: Location
  properties: {
    activeActive: true
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
            id: (!GatewaySubnetExists) ? ExistingVnetNewGatewaySubnet.id : ExistingGatewaySubnetId
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
            id: (!GatewaySubnetExists) ? ExistingVnetNewGatewaySubnet.id : ExistingGatewaySubnetId
          }
          publicIPAddress: {
            id: NewGatewayPIP2.id
          }
        }
      }
    ]
  }
}


output VNetName string = ExistingVNet.name
output GatewayName string = (!GatewayExists) ? ExistingVnetNewGateway.name : ExistingGateway.name
output ExistingGatewayName string = ExistingGateway.name
output VNetResourceId string = ExistingVNet.id
