targetScope = 'subscription'

param Location string
param Prefix string

@sys.description('Tags to be applied to resources')
param tags object

resource NetworkResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${Prefix}-Network'
  location: Location
  tags: tags
}

output NetworkResourceGroup string = NetworkResourceGroup.name
