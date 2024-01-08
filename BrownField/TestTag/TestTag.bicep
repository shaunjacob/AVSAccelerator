targetScope = 'subscription'

@description('The prefix to use on resources inside this template')
@minLength(1)
@maxLength(20)
param Prefix string = 'AVSTestTag1'

@description('Optional: The location the private cloud should be deployed to, by default this will be the location of the deployment')
param Location string = deployment().location


//Tags
@sys.description('Apply tags on resources and resource groups. (Default: false)')
param createResourceTags bool = true

@sys.description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()
param timeShort string = utcNow('d')
param workloadTypeTag string = ''
param departmentTag string = ''
param ownerTag string = 'boss'
param costCenterTag string = 'moneybags'

var varAVSDefaultTags = {
  ServiceWorkload: 'AVS'
  CreationTimeUTC: time
  CreationTimeUTCShort: timeShort
}

var varCustomResourceTags = createResourceTags ? {
  WorkloadType: workloadTypeTag
  Department: departmentTag
  Owner: ownerTag
  CostCenter: costCenterTag
} : {}


var deploymentPrefix = 'AVS-${uniqueString(deployment().name, Location)}'

module Networking 'Modules/Networking.bicep' = {
  name: '${deploymentPrefix}-Network'
  params: {
    Prefix: Prefix
    Location: Location
    tags: createResourceTags ? union(varCustomResourceTags, varAVSDefaultTags) : varAVSDefaultTags
  }
}
