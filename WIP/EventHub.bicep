// param eventHubNamespaceName string = 'sjeventhubtest01'

// @description('Specifies the Azure location for all resources.')
// param location string = resourceGroup().location

// @description('Specifies the messaging tier for Event Hub Namespace.')
// @allowed([
//   'Basic'
//   'Standard'
// ])
// param eventHubSku string = 'Standard'


// resource eventHubNamespace 'Microsoft.EventHub/namespaces@2021-11-01' = {
//   name: eventHubNamespaceName
//   location: location
//   sku: {
//     name: eventHubSku
//     tier: eventHubSku
//     capacity: 1
//   }
//   properties: {
//     isAutoInflateEnabled: false
//     maximumThroughputUnits: 0
//   }
// }

// // resource eventHub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
// //   parent: eventHubNamespace
// //   name: eventHubName
// //   properties: {
// //     messageRetentionInDays: 7
// //     partitionCount: 1
// //   }
// // }

// output eventHubNamespaceid string = eventHubNamespace.id
