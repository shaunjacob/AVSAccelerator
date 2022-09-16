//Parameters
param Location string = resourceGroup().location
param PrivateCloudName string
param PrivateCloudResourceId string
param DeployDashboard bool
param DeployMetricAlerts bool
param DeployServiceHealth bool
param ActionGroupEmails string

//Variables
var Alerts = [
  {
    Name: 'CPU'
    Description: 'CPU Usage per Cluster'
    Metric: 'EffectiveCpuAverage'
    SplitDimension: 'clustername'
    Threshold: 80
    Severity: 2
  }
  {
    Name: 'Memory'
    Description: 'Memory Usage per Cluster'
    Metric: 'UsageAverage'
    SplitDimension: 'clustername'
    Threshold: 80
    Severity: 2
  }
  {
    Name: 'Storage'
    Description: 'Storage Usage per Datastore'
    Metric: 'DiskUsedPercentage'
    SplitDimension: 'dsname'
    Threshold: 70
    Severity: 2
  }
  {
    Name: 'StorageCritical'
    Description: 'Storage Usage per Datastore'
    Metric: 'DiskUsedPercentage'
    SplitDimension: 'dsname'
    Threshold: 75
    Severity: 0
  }
]

var DashboardHeading = {
  position: {
    colSpan: 6
    rowSpan: 1
    x: 0
    y: 0
  }
  metadata: {
    type: 'Extension/HubsExtension/PartType/MarkdownPart'
    inputs: []
    settings: {
      content: {
        settings:{
          content: '# AVS Private Cloud Metrics'
          title: ''
          subtitle: ''
          markdownSource: 1
        }
      }
    }
  }
}

var PrivateCloudLink = {
  position: {
    colSpan: 6
    rowSpan: 1
    x: 6
    y: 0
  }
  metadata:{
    type: 'Extension/HubsExtension/PartType/ResourcePart'
    asset: {
      idInputName: 'id'
    }
    inputs: [
      {
        name: 'id'
        value: PrivateCloudResourceId
      }
    ]
  }
}

var PrivateCloudCPUMetric = {
  position: {
    colSpan: 6
    rowSpan: 4
    x: 0
    y: 1
  }
  metadata: {
    type: 'Extension/HubsExtension/PartType/MonitorChartPart'
    inputs: [
      {
        name: 'options'
        value: {
          chart: {
            metrics: [
              {
                resourceMetadata: {
                  id: PrivateCloudResourceId
                }
                name: 'EffectiveCpuAverage'
                aggregationType: 4
                namespace: 'microsoft.avs/privateclouds'
                metricVisualization: {
                  displayName: 'Percentage CPU'
                }
              }
            ]
            title: 'Percentage CPU by Cluster Name'
            titleKind: 1
            visualization: {
              chartType: 2
              legendVisualization: {
                isVisible: true
                position: 2
                hideSubtitle: false
              }
              axisVisualization: {
                x: {
                  isVisible: true
                  axisType: 2
                }
                y: {
                  isVisible: true
                  axisType: 1
                }
              }
            }
            grouping: {
              dimension: 'clustername'
              sort: 2
              top: 10
            }
          }
        }
      }
    ]
  }
}

var PrivateCloudDiskMetric = {
  position: {
    colSpan: 6
    rowSpan: 4
    x: 6
    y: 1
  }
  metadata: {
    type: 'Extension/HubsExtension/PartType/MonitorChartPart'
    inputs: [
      {
        name: 'options'
        value: {
          chart: {
            metrics: [
              {
                resourceMetadata: {
                  id: PrivateCloudResourceId
                }
                name: 'DiskUsedPercentage'
                aggregationType: 4
                namespace: 'microsoft.avs/privateclouds'
                metricVisualization: {
                  displayName: ' Percentage Datastore Disk Used'
                }
              }
            ]
            title: 'Percentage Datastore Disk Used by Datastore'
            titleKind: 1
            visualization: {
              chartType: 2
              legendVisualization: {
                isVisible: true
                position: 2
                hideSubtitle: false
              }
              axisVisualization: {
                x: {
                  isVisible: true
                  axisType: 2
                }
                y: {
                  isVisible: true
                  axisType: 1
                }
              }
            }
            grouping: {
              dimension: 'dsname'
              sort: 2
              top: 10
            }
          }
        }
      }
    ]
  }
}

var PrivateCloudMemoryMetric = {
  position: {
    colSpan: 6
    rowSpan: 4
    x: 0
    y: 5
  }
  metadata: {
    type: 'Extension/HubsExtension/PartType/MonitorChartPart'
    inputs: [
      {
        name: 'options'
        value: {
          chart: {
            metrics: [
              {
                resourceMetadata: {
                  id: PrivateCloudResourceId
                }
                name: 'UsageAverage'
                aggregationType: 4
                namespace: 'microsoft.avs/privateclouds'
                metricVisualization: {
                  displayName: 'Average Memory Usage'
                }
              }
            ]
            title: 'Average Memory Usage by Cluster Name'
            titleKind: 1
            visualization: {
              chartType: 2
              legendVisualization: {
                isVisible: true
                position: 2
                hideSubtitle: false
              }
              axisVisualization: {
                x: {
                  isVisible: true
                  axisType: 2
                }
                y: {
                  isVisible: true
                  axisType: 1
                }
              }
            }
            grouping: {
              dimension: 'clustername'
              sort: 2
              top: 10
            }
          }
        }
      }
    ]
  }
}

resource ActionGroup 'microsoft.insights/actionGroups@2019-06-01' = if ((DeployMetricAlerts) || (DeployServiceHealth)) {
  name: '${PrivateCloudName}-ActionGroup'
  location: 'Global'
  properties:{
    enabled: true
    groupShortName: substring('avs${uniqueString(PrivateCloudName)}', 0, 12)
    emailReceivers: [ 
      {
        emailAddress: ActionGroupEmails
        name: split(ActionGroupEmails, '@')[0]
        useCommonAlertSchema: false
      }
  ]
  }
}

resource MetricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = [for Alert in Alerts: if (DeployMetricAlerts) {
  name: '${PrivateCloudName}-${Alert.Name}'
  location: 'Global'
  properties: {
    description: Alert.Description
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf:[
        {
          name: 'Metric1'
          operator: 'GreaterThan'
          threshold: Alert.Threshold
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
          metricName: Alert.Metric
          dimensions: [
            {
              name: Alert.SplitDimension
              operator: 'Include'
              values: [
                '*'
              ]
            }
          ]
        }
      ]
    }
    scopes: [
      PrivateCloudResourceId
    ]
    severity: Alert.Severity
    evaluationFrequency: 'PT5M'
    windowSize: 'PT30M'
    autoMitigate: true
    enabled: true
    actions: [
      {
        actionGroupId: ActionGroup.id
      }
    ]
  }
}]

// Deploy service health alerts
resource ServiceHealthAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = if (DeployServiceHealth) {
  name: '${PrivateCloudName}-ServiceHealth'
  location: 'Global'
  properties: {
    description: 'Service Health Alerts'
    condition:{
      allOf: [
        {
          field: 'category'
          equals: 'ServiceHealth'
        }
        {
          field: 'properties.impactedServices[*].ServiceName'
          containsAny: [
            'Azure VMware Solution'
          ]
        }
        {
          field: 'properties.impactedServices[*].ImpactedRegions[*].RegionName'
          containsAny: [
            reference(PrivateCloudResourceId, '2021-06-01', 'Full').location
            'Global'
          ]
        }
      ]
    }
    scopes: [
      subscription().id
    ]
    enabled: true
    actions: {
      actionGroups: [
        {
          actionGroupId: ActionGroup.id
        }
      ]
    }
  }
}


resource Dashboard 'Microsoft.Portal/dashboards@2019-01-01-preview' = if (DeployDashboard) {
  name: '${PrivateCloudName}-Dashboard'
  location: Location
  properties: {
    lenses: {
      '0': {
        order: 0
        parts: {
          '0': DashboardHeading
          '1': PrivateCloudLink
          '4': PrivateCloudDiskMetric
          '5': PrivateCloudCPUMetric
          '6': PrivateCloudMemoryMetric
        }
      }
    }
  }
  tags:{
    'hidden-title': '${PrivateCloudName}-Dashboard'
  }
}

output ActionGroupResourceId string = ActionGroup.id
