param Location string

@description('The unique guid for this workbook instance')
param workbookId string = newGuid()

var workbookContent = {
  version: 'Notebook/1.0'
  items: [
    {
      type: 9
      content: {
        version: 'KqlParameterItem/1.0'
        crossComponentResources: [
          '{Subscription}'
        ]
        parameters: [
          {
            id: '0e322c64-be41-4f52-ba5b-df55cf94e41d'
            version: 'KqlParameterItem/1.0'
            name: 'TimeRange'
            type: 4
            isRequired: true
            value: {
              durationMs: 604800000
            }
            typeSettings: {
              selectableValues: [
                {
                  durationMs: 3600000
                }
                {
                  durationMs: 14400000
                }
                {
                  durationMs: 43200000
                }
                {
                  durationMs: 86400000
                }
                {
                  durationMs: 172800000
                }
                {
                  durationMs: 259200000
                }
                {
                  durationMs: 604800000
                }
                {
                  durationMs: 1209600000
                }
                {
                  durationMs: 2592000000
                }
                {
                  durationMs: 5184000000
                }
                {
                  durationMs: 7776000000
                }
              ]
              allowCustom: true
            }
            timeContext: {
              durationMs: 86400000
            }
          }
          {
            id: '69be2f0e-ec9f-4cb2-bef0-e437c0b01789'
            version: 'KqlParameterItem/1.0'
            name: 'Subscription'
            type: 6
            isRequired: true
            multiSelect: true
            quote: '\''
            delimiter: ','
            query: 'where type =~ \'microsoft.avs/privateclouds\'\r\n| summarize Count = count() by subscriptionId\r\n\t| order by Count desc\r\n\t| extend Rank = row_number()\r\n\t| project value = subscriptionId, label = subscriptionId, selected = Rank == 1'
            crossComponentResources: [
              'value::all'
            ]
            value: [
              'value::all'
            ]
            typeSettings: {
              additionalResourceOptions: [
                'value::1'
                'value::all'
              ]
              showDefault: false
            }
            timeContext: {
              durationMs: 86400000
            }
            queryType: 1
            resourceType: 'microsoft.resourcegraph/resources'
          }
          {
            id: '569baca3-cd50-4a2c-a701-423682ee14fb'
            version: 'KqlParameterItem/1.0'
            name: 'Workspace'
            type: 5
            isRequired: true
            multiSelect: true
            quote: '\''
            delimiter: ','
            query: 'where type =~ \'microsoft.operationalinsights/workspaces\'\r\n| project id'
            crossComponentResources: [
              '{Subscription}'
            ]
            typeSettings: {
              additionalResourceOptions: [
                'value::all'
              ]
              showDefault: false
            }
            timeContext: {
              durationMs: 86400000
            }
            queryType: 1
            resourceType: 'microsoft.resourcegraph/resources'
            value: [
              'value::all'
            ]
          }
          {
            id: '85d960b8-e89c-42ee-bf8c-fa95ce925c5d'
            version: 'KqlParameterItem/1.0'
            name: 'ChangeLog'
            label: 'Change Log'
            type: 10
            isRequired: true
            typeSettings: {
              additionalResourceOptions: []
              showDefault: false
            }
            jsonData: '[\r\n { "value": "Yes", "label": "Yes"},\r\n { "value": "No", "label": "No", "selected":true }\r\n]'
            timeContext: {
              durationMs: 86400000
            }
          }
        ]
        style: 'pills'
        queryType: 1
        resourceType: 'microsoft.resourcegraph/resources'
      }
      name: 'parameters - 0'
    }
    {
      type: 1
      content: {
        json: '# This workbook shows information relevant to deployed Azure VMware Solutions'
      }
      name: 'text - 4'
    }
    {
      type: 1
      content: {
        json: '# Change Log\r\n\r\n### Version 1\r\nThis is the original version of the AVS workbooks and features:\r\n1. A summary of the AVS solutions deployed\r\n2. Metrics performance view\r\n3. Activity section related to AVS\r\n\r\nVersion 2\r\nAdded VMware resource view\r\n\r\n### Version 3 \r\nAdded VM Information \r\n\r\n### Version 4\r\nAdded Alert information\r\n\r\n### Version 5\r\nAdded help for configuring Alerts\r\n\r\n### Version 6\r\nAdded Advisor recommendations\r\nAdded impact filter for Advisor recommendations\r\nAdded status VM tools\r\n\r\n### Version 7\r\nAdded help for Activity tab view\r\n\r\n### Version 8\r\nAdded syslog information\r\nEnabled more info slyout for syslog\r\nPresented workspace parameter in general instead of hidden'
      }
      conditionalVisibility: {
        parameterName: 'ChangeLog'
        comparison: 'isEqualTo'
        value: 'Yes'
      }
      name: 'text - 5'
    }
    {
      type: 11
      content: {
        version: 'LinkItem/1.0'
        style: 'tabs'
        links: [
          {
            id: 'ce43bd96-a673-4b26-a580-023b0ff3ba86'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Summary'
            subTarget: 'Summary'
            style: 'link'
          }
          {
            id: '22d35b15-a48c-4b5f-b450-af89b26ae824'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Resources'
            subTarget: 'Resources'
            style: 'link'
          }
          {
            id: '1ee7d9cd-7d81-4425-baf5-c5d41492b2b7'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Virtual Machines'
            subTarget: 'VM'
            style: 'link'
          }
          {
            id: '0a60794e-c6ef-4cbc-91db-cb2dca983938'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Alerts'
            subTarget: 'Alerts'
            style: 'link'
          }
          {
            id: '2fdb4cac-6ce8-4481-867a-cfe4e50e1ed7'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'SysLog'
            subTarget: 'SysLog'
            style: 'link'
          }
          {
            id: '6fbc03e5-8cc5-45e9-bd24-c3126b51c1e4'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Advisor Recommendations'
            subTarget: 'Advisor'
            style: 'link'
          }
          {
            id: 'a33b5afe-5513-447e-98a5-3f67a3704ee1'
            cellValue: 'Tab'
            linkTarget: 'parameter'
            linkLabel: 'Activity'
            subTarget: 'Activity'
            style: 'link'
          }
        ]
      }
      name: 'links - 3'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'resources \r\n| where type contains \'microsoft.avs/privatecloud\'\r\n| extend SKU1 = tostring(sku.name)\r\n| extend endpoints = properties.endpoints\r\n| extend availability = tostring(properties.availability.strategy)\r\n| extend clustersize = tostring(properties.managementCluster.clusterSize)\r\n| extend hosts = properties.managementCluster.hosts\r\n//| mv-expand hosts\r\n| extend expressRouteID = tostring(properties.circuit.expressRouteID)\r\n| project id, hosts,location, SKU1, clustersize, availability, expressRouteID,name //endpoints'
              size: 1
              title: 'AVS Summary'
              exportedParameters: [
                {
                  fieldName: 'name'
                  parameterName: 'Name'
                }
                {
                  fieldName: 'rg'
                  parameterName: 'rg'
                  parameterType: 1
                }
                {
                  fieldName: 'sub'
                  parameterName: 'sub'
                  parameterType: 1
                }
                {
                  fieldName: 'id'
                  parameterName: 'RID'
                  parameterType: 1
                }
              ]
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: 'hosts'
                    formatter: 0
                    formatOptions: {
                      customColumnWidthSetting: '42ch'
                    }
                  }
                  {
                    columnMatch: 'location'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'Sev4'
                          text: '{0}{1}'
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'name'
                    formatter: 5
                    formatOptions: {
                      customColumnWidthSetting: '18ch'
                    }
                  }
                  {
                    columnMatch: 'rg'
                    formatter: 5
                  }
                ]
                filter: true
                labelSettings: [
                  {
                    columnId: 'id'
                    label: 'Name'
                  }
                  {
                    columnId: 'hosts'
                    label: 'Hosts'
                  }
                  {
                    columnId: 'location'
                    label: 'Location'
                  }
                  {
                    columnId: 'SKU1'
                    label: 'SKU'
                  }
                  {
                    columnId: 'clustersize'
                    label: 'Size'
                  }
                  {
                    columnId: 'availability'
                    label: 'Availability Strategy'
                  }
                  {
                    columnId: 'expressRouteID'
                    label: 'ExpressRoute'
                  }
                ]
              }
            }
            conditionalVisibility: {
              parameterName: 'Tab'
              comparison: 'isEqualTo'
              value: 'Summary'
            }
            name: 'query - 1'
          }
          {
            type: 1
            content: {
              json: 'Select an AVS instance to show performance information'
            }
            name: 'text - 6'
          }
          {
            type: 12
            content: {
              version: 'NotebookGroup/1.0'
              groupType: 'editable'
              title: 'Performance'
              items: [
                {
                  type: 10
                  content: {
                    chartId: 'cdc934ef-754d-450e-8f48-df06ba1fc457'
                    version: 'MetricsItem/2.0'
                    size: 0
                    chartType: 2
                    resourceType: 'Microsoft.AVS/privateClouds'
                    metricScope: 0
                    resourceParameter: 'RID'
                    resourceIds: [
                      '{RID}'
                    ]
                    timeContextFromParameter: 'TimeRange'
                    timeContext: {
                      durationMs: 2592000000
                    }
                    metrics: [
                      {
                        namespace: 'microsoft.avs/privateclouds'
                        metric: 'microsoft.avs/privateclouds--EffectiveCpuAverage'
                        aggregation: 4
                      }
                    ]
                    title: 'Average CPU Percentage'
                    showRefreshButton: true
                    gridSettings: {
                      rowLimit: 10000
                    }
                  }
                  customWidth: '50'
                  name: 'metric - 0'
                }
                {
                  type: 10
                  content: {
                    chartId: '5c45ea12-c13b-4aa7-b4fc-5c49b883120c'
                    version: 'MetricsItem/2.0'
                    size: 0
                    chartType: 2
                    resourceType: 'Microsoft.AVS/privateClouds'
                    metricScope: 0
                    resourceParameter: 'RID'
                    resourceIds: [
                      '{RID}'
                    ]
                    timeContextFromParameter: 'TimeRange'
                    timeContext: {
                      durationMs: 2592000000
                    }
                    metrics: [
                      {
                        namespace: 'microsoft.avs/privateclouds'
                        metric: 'microsoft.avs/privateclouds--DiskUsedPercentage'
                        aggregation: 4
                      }
                    ]
                    title: 'Percentage Datastore Disk Used'
                    showRefreshButton: true
                    gridSettings: {
                      rowLimit: 10000
                    }
                  }
                  customWidth: '50'
                  name: 'metric - 1'
                }
                {
                  type: 10
                  content: {
                    chartId: '6071b852-d848-44a7-baa2-71667cdcac3b'
                    version: 'MetricsItem/2.0'
                    size: 0
                    chartType: 2
                    resourceType: 'Microsoft.AVS/privateClouds'
                    metricScope: 0
                    resourceParameter: 'RID'
                    resourceIds: [
                      '{RID}'
                    ]
                    timeContextFromParameter: 'TimeRange'
                    timeContext: {
                      durationMs: 2592000000
                    }
                    metrics: [
                      {
                        namespace: 'microsoft.avs/privateclouds'
                        metric: 'microsoft.avs/privateclouds--UsageAverage'
                        aggregation: 4
                      }
                    ]
                    title: 'Average Memory Used'
                    showRefreshButton: true
                    gridSettings: {
                      rowLimit: 10000
                    }
                  }
                  customWidth: '50'
                  name: 'metric - 2'
                }
              ]
            }
            conditionalVisibility: {
              parameterName: 'Name'
              comparison: 'isNotEqualTo'
            }
            name: 'Performance'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'Summary'
      }
      name: 'Group - Summary'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'resources\r\n| where type contains "microsoft.connectedvmwarevsphere" and type !contains "virtualmachines" and type !contains "microsoft.connectedvmwarevsphere/virtualnetworks" and type !contains "microsoft.connectedvmwarevsphere/virtualmachinetemplates"\r\n| extend resource = tolower(tostring(split(type, "/")[1]))\r\n| summarize count(resource) by resource'
              size: 4
              exportFieldName: 'resource'
              exportParameterName: 'R'
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'tiles'
              tileSettings: {
                showBorder: false
                titleContent: {
                  columnMatch: 'resource'
                  formatter: 1
                }
                leftContent: {
                  columnMatch: 'count_resource'
                  formatter: 12
                  formatOptions: {
                    palette: 'auto'
                  }
                  numberFormat: {
                    unit: 17
                    options: {
                      maximumSignificantDigits: 3
                      maximumFractionDigits: 2
                    }
                  }
                }
              }
            }
            name: 'query - 0'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'resources\r\n| where type contains "microsoft.connectedvmwarevsphere" and type !contains "virtualmachines" and type !contains "microsoft.connectedvmwarevsphere/virtualnetworks" and type !contains "microsoft.connectedvmwarevsphere/virtualmachinetemplates"\r\n| extend resource = tolower(tostring(split(type, "/")[1]))\r\n| extend Tag = iff(notempty(tags),tags,"No Tags")\r\n//| extend RGID = strcat({Subscription},"/resourceGroups/",resourceGroup)\r\n| project id,resource,  resourceGroup, Tag//, RGID\r\n| order by resource'
              size: 0
              title: 'All Resources'
              showRefreshButton: true
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: 'resourceGroup'
                    formatter: 13
                    formatOptions: {
                      linkTarget: 'Resource'
                      showIcon: true
                    }
                  }
                  {
                    columnMatch: 'RGID'
                    formatter: 14
                    formatOptions: {
                      linkTarget: null
                      showIcon: true
                    }
                  }
                ]
                filter: true
                labelSettings: [
                  {
                    columnId: 'id'
                    label: 'Name'
                  }
                  {
                    columnId: 'resource'
                    label: 'Resource'
                  }
                  {
                    columnId: 'resourceGroup'
                    label: 'Resource Group'
                  }
                  {
                    columnId: 'Tag'
                    label: 'Tags'
                  }
                ]
              }
            }
            conditionalVisibility: {
              parameterName: 'R'
              comparison: 'isEqualTo'
            }
            name: 'query - 1'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'resources\r\n| where type contains "microsoft.connectedvmwarevsphere" and type !contains "virtualmachines" and type !contains "microsoft.connectedvmwarevsphere/virtualnetworks" and type !contains "microsoft.connectedvmwarevsphere/virtualmachinetemplates"\r\n| extend resource = tolower(tostring(split(type, "/")[1]))\r\n| extend Tag = iff(notempty(tags),tags,"No Tags")\r\n| where resource == "{R}"\r\n| project id,resource,  resourceGroup, Tag\r\n| order by resource'
              size: 0
              title: '{R}'
              showRefreshButton: true
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              gridSettings: {
                filter: true
              }
            }
            conditionalVisibility: {
              parameterName: 'R'
              comparison: 'isNotEqualTo'
            }
            name: 'query - 2'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'Resources'
      }
      name: 'Group - AVS Resources'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 9
            content: {
              version: 'KqlParameterItem/1.0'
              crossComponentResources: [
                '{Subscription}'
              ]
              parameters: [
                {
                  id: '0d65bc28-3879-4da7-a1f7-792b5e882fd9'
                  version: 'KqlParameterItem/1.0'
                  name: 'LatestToolsVer'
                  type: 2
                  isRequired: true
                  query: 'resources\r\n| where type ==  "microsoft.connectedvmwarevsphere/virtualmachines" \r\n| extend toolsVersion = toint(properties.osProfile.toolsVersion)\r\n| project toolsVersion\r\n| order by toolsVersion desc\r\n| top 1 by toolsVersion'
                  crossComponentResources: [
                    '{Subscription}'
                  ]
                  isHiddenWhenLocked: true
                  typeSettings: {
                    additionalResourceOptions: [
                      'value::1'
                    ]
                    showDefault: false
                  }
                  timeContext: {
                    durationMs: 86400000
                  }
                  queryType: 1
                  resourceType: 'microsoft.resourcegraph/resources'
                  value: 'value::1'
                }
              ]
              style: 'pills'
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
            }
            name: 'parameters - 1'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'resources\r\n| where type ==  "microsoft.connectedvmwarevsphere/virtualmachines" \r\n| extend VSID = tolower(tostring(split(properties.vCenterId, "/")[8]))\r\n| extend OS = properties.osProfile\r\n| extend computerName = properties.osProfile.computerName\r\n| extend osType = properties.osProfile.osType\r\n| extend osName = properties.osProfile.osName\r\n| extend toolsRunningStatus = properties.osProfile.toolsRunningStatus\r\n| extend toolsVersion = toint(properties.osProfile.toolsVersion)\r\n| extend cores = properties.hardwareProfile.numCoresPerSocket\r\n| extend mem = properties.hardwareProfile.memorySizeMB\r\n| extend CPUs = properties.hardwareProfile.numCPUs\r\n| extend Power =  properties.powerState\r\n| project id, VSID, osType, osName,CPUs, cores, mem, Power,toolsRunningStatus, toolsVersion'
              size: 0
              showRefreshButton: true
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: 'VSID'
                    formatter: 0
                    formatOptions: {
                      customColumnWidthSetting: '20.2857ch'
                    }
                  }
                  {
                    columnMatch: 'osType'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'colors'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'Windows'
                          representation: 'lightBlue'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'Linux'
                          representation: 'green'
                          text: '{0}{1}'
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'gray'
                          text: 'Unknown'
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'osName'
                    formatter: 1
                    formatOptions: {
                      customColumnWidthSetting: '29.1429ch'
                    }
                  }
                  {
                    columnMatch: 'CPUs'
                    formatter: 1
                  }
                  {
                    columnMatch: 'cores'
                    formatter: 1
                  }
                  {
                    columnMatch: 'mem'
                    formatter: 1
                  }
                  {
                    columnMatch: 'Power'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'poweredOn'
                          representation: 'success'
                          text: ''
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'Unavailable'
                          text: ''
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'toolsRunningStatus'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'guestToolsRunning'
                          representation: 'success'
                          text: ''
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: '4'
                          text: ''
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'Powered On'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'poweredOn'
                          representation: 'success'
                          text: ''
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'info'
                          text: ''
                        }
                      ]
                    }
                  }
                ]
                filter: true
                labelSettings: [
                  {
                    columnId: 'id'
                    label: 'VM'
                  }
                  {
                    columnId: 'VSID'
                    label: 'vCenter'
                  }
                  {
                    columnId: 'osType'
                    label: 'OS'
                  }
                  {
                    columnId: 'osName'
                    label: 'OS Version'
                  }
                  {
                    columnId: 'CPUs'
                    label: 'CPUs'
                  }
                  {
                    columnId: 'cores'
                    label: 'Cores'
                  }
                  {
                    columnId: 'mem'
                    label: 'Memory'
                  }
                  {
                    columnId: 'Power'
                    label: 'Powered On'
                  }
                  {
                    columnId: 'toolsRunningStatus'
                    label: 'Guest Managed'
                  }
                  {
                    columnId: 'toolsVersion'
                    label: 'Tools Version'
                  }
                ]
              }
            }
            name: 'query - 0'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'VM'
      }
      name: 'Group - AVS Virtual Machines'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 9
            content: {
              version: 'KqlParameterItem/1.0'
              parameters: [
                {
                  id: '9db8b056-5686-409d-a589-9ae87eed9cee'
                  version: 'KqlParameterItem/1.0'
                  name: 'ShowHelp'
                  label: 'Show Alert Help'
                  type: 10
                  isRequired: true
                  typeSettings: {
                    additionalResourceOptions: []
                  }
                  jsonData: '[\r\n { "value": "Yes", "label": "Yes"},\r\n { "value": "No", "label": "No", "selected":true }\r\n]'
                  timeContext: {
                    durationMs: 86400000
                  }
                }
              ]
              style: 'pills'
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
            }
            name: 'parameters - 5'
          }
          {
            type: 1
            content: {
              json: 'In order to deploy alerts you will need the resource ID for the AVS instance you want to be alerted on. Alerts will also need to be deployed for each separate AVS instance.\r\n\r\nTo get the resource ID, navigate to the Overview blade of the required AVS instance and click on **"JSON View"** in the top right corner. The ID will be at the top of the fly out menu and looks as follow:\r\n\r\n**Example:** /subscriptions/"subscription ID"/resourceGroups/"Resource Group"/providers/Microsoft.AVS/privateClouds/"AVS instance name"'
            }
            conditionalVisibility: {
              parameterName: 'ShowHelp'
              comparison: 'isEqualTo'
              value: 'Yes'
            }
            name: 'text - 4'
          }
          {
            type: 11
            content: {
              version: 'LinkItem/1.0'
              style: 'nav'
              links: [
                {
                  id: '11763710-bc13-4652-85c8-e2fa66a62c0a'
                  cellValue: 'https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FBrownField%2FMonitoring%2FAVS-Utilization-Alerts%2FARM%2FAVSMonitor.deploy.json'
                  linkTarget: 'Url'
                  linkLabel: 'Deploy Metric Alerts'
                  style: 'link'
                }
                {
                  id: '93c23f27-38e9-429c-a1fb-3c24fa4b17fd'
                  cellValue: 'https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FBrownField%2FMonitoring%2FAVS-Service-Health%2FARM%2FAVSServiceHealth.deploy.json'
                  linkTarget: 'Url'
                  linkLabel: 'Deploy Service Health Alerts'
                  style: 'link'
                }
              ]
            }
            name: 'links - 6'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'alertsmanagementresources\r\n| extend FireTime = todatetime(properties.essentials.startDateTime), \r\n         Severity = tostring(properties.essentials.severity), \r\n         MonitorCondition = tostring(properties.essentials.monitorCondition), \r\n         AlertTarget = tostring(properties.essentials.targetResourceType), \r\n         MonitorService = tostring(properties.essentials.monitorService)\r\n//| where FireTime {TimeRange}\r\n| extend AlertTarget = case(\r\n        MonitorService == \'ActivityLog Administrative\', \'ActivityLog\',\r\n        AlertTarget == \'microsoft.insights/components\', \'App Insights\',\r\n        AlertTarget == \'microsoft.operationalinsights/workspaces\', \'Log Analytics\', \r\n        AlertTarget)\r\n| extend Total = "TotalAlerts"\r\n| where (id contains "microsoft.connectedvmwarevsphere") or (id contains "microsoft.avs/privatecloud")\r\n| summarize TotalAlerts= count(MonitorCondition) by Total'
              size: 4
              title: 'Alert Summary'
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'tiles'
              tileSettings: {
                showBorder: false
                titleContent: {
                  columnMatch: 'Total'
                  formatter: 1
                }
                leftContent: {
                  columnMatch: 'TotalAlerts'
                  formatter: 12
                  formatOptions: {
                    palette: 'auto'
                  }
                  numberFormat: {
                    unit: 17
                    options: {
                      maximumSignificantDigits: 3
                      maximumFractionDigits: 2
                    }
                  }
                }
              }
            }
            customWidth: '25'
            name: 'query - 1'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'alertsmanagementresources\r\n| where (id contains "microsoft.connectedvmwarevsphere") or (id contains "microsoft.avs/privatecloud")\r\n| extend FireTime = todatetime(properties.essentials.startDateTime), \r\n         Severity = tostring(properties.essentials.severity), \r\n         MonitorCondition = tostring(properties.essentials.monitorCondition), \r\n         AlertTarget = tostring(properties.essentials.targetResourceType), \r\n         MonitorService = tostring(properties.essentials.monitorService)\r\n| where FireTime {TimeRange}\r\n| extend AlertTarget = case(\r\n        MonitorService == \'ActivityLog Administrative\', \'ActivityLog\',\r\n        AlertTarget == \'microsoft.insights/components\', \'App Insights\',\r\n        AlertTarget == \'microsoft.operationalinsights/workspaces\', \'Log Analytics\', \r\n        AlertTarget)\r\n| summarize count() by Severity'
              size: 4
              title: 'Severity Summary'
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'tiles'
              tileSettings: {
                showBorder: false
                titleContent: {
                  columnMatch: 'Severity'
                  formatter: 1
                }
                leftContent: {
                  columnMatch: 'count_'
                  formatter: 12
                  formatOptions: {
                    palette: 'auto'
                  }
                  numberFormat: {
                    unit: 17
                    options: {
                      maximumSignificantDigits: 3
                      maximumFractionDigits: 2
                    }
                  }
                }
              }
            }
            customWidth: '75'
            name: 'query - 2'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'alertsmanagementresources\r\n| where (id contains "microsoft.connectedvmwarevsphere") or (id contains "microsoft.avs/privatecloud")\r\n| extend FireTime = todatetime(properties.essentials.startDateTime), \r\n         LastModifiedTime = todatetime(properties.essentials.lastModifiedDateTime),\r\n         Severity = tostring(properties.essentials.severity), \r\n         MonitorCondition = tostring(properties.essentials.monitorCondition), \r\n         AlertTarget = tostring(properties.essentials.targetResourceType), \r\n         MonitorService = tostring(properties.essentials.monitorService),\r\n         ResolvedTime = todatetime(properties.essentials.monitorConditionResolvedDateTime)\r\n| where FireTime {TimeRange}\r\n| extend AlertTarget = case(\r\n                MonitorService == \'ActivityLog Administrative\', \'ActivityLog\',\r\n                AlertTarget == \'microsoft.insights/components\', \'App Insights\',\r\n                AlertTarget == \'microsoft.operationalinsights/workspaces\', \'Log Analytics\', \r\n                AlertTarget)          \r\n| mv-expand Condition = properties.context.context.condition.allOf\r\n| extend SignalLogic = case(\r\n                MonitorService == "VM Insights - Health", strcat("VM Health for ", properties.essentials.targetResourceName, " Changed from ", properties.context.monitorStateBeforeAlertCreated, " to ", properties.context.monitorStateWhenAlertCreated),\r\n                AlertTarget == "ActivityLog", strcat("When the Activity Log has Category = ", properties.context.context.activityLog.properties.eventCategory, " and Signal name = ", properties.context.context.activityLog.properties.message),\r\n                MonitorService == "Smart Detector", strcat(properties.SmartDetectorName, " Detected failure rate of ", properties.DetectedFailureRate, " above normal failure rate of ", properties.context.NormalFailureRate),\r\n                MonitorService == "Log Analytics", strcat("Alert when ", properties.context.AlertType, " is ", properties.context.AlertThresholdOperator, " threshold ", properties.context.AlertThresholdValue),\r\n                MonitorService == "ActivityLog Autoscale", strcat(properties.context.context.activityLog.operationName, " from ", properties.context.context.activityLog.properties.oldInstancesCount, " to ", properties.context.context.activityLog.properties.newInstancesCount),\r\n                strcat("Alert when metric ", Condition.metricName, Condition.timeAggregation, " is ", Condition.operator, " threshold ", Condition.threshold)),\r\n         Query = case(\r\n                 MonitorService == "Log Alerts V2", tostring(Condition.searchQuery),\r\n                 MonitorService == "Log Analytics", tostring(properties.context.SearchQuery), "N/A"),\r\n         MetricValue = iff(MonitorService == "Log Analytics", toint(properties.context.ResultCount), toint(Condition.metricValue)),\r\n         ResourceName = iff(AlertTarget == "ActivityLog", properties.context.context.activityLog.subscriptionId, tostring(properties.essentials.targetResourceName))\r\n| extend OpenTime = iff(MonitorCondition == "Resolved", datetime_diff(\'minute\', ResolvedTime, FireTime), datetime_diff(\'minute\', now(), FireTime)),\r\n         Details = pack_all()\r\n| project name, AlertTarget, id, subscriptionId, MonitorCondition, FireTime, LastModifiedTime, OpenTime, SignalLogic, Query, MetricValue, ResourceName, Details'
              size: 0
              showRefreshButton: true
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: '$gen_group'
                    formatter: 15
                    formatOptions: {
                      linkTarget: 'OpenBlade'
                      linkIsContextBlade: true
                      showIcon: true
                      bladeOpenContext: {
                        bladeName: 'AlertDetailsTemplateBlade'
                        extensionName: 'Microsoft_Azure_Monitoring'
                        bladeParameters: [
                          {
                            name: 'alertId'
                            source: 'column'
                            value: 'id'
                          }
                          {
                            name: 'alertName'
                            source: 'column'
                            value: 'name'
                          }
                          {
                            name: 'invokedFrom'
                            source: 'static'
                            value: 'Workbooks'
                          }
                        ]
                      }
                    }
                  }
                  {
                    columnMatch: 'name'
                    formatter: 5
                  }
                  {
                    columnMatch: 'id'
                    formatter: 5
                  }
                  {
                    columnMatch: 'MonitorCondition'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'Fired'
                          representation: '2'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'Resolved'
                          representation: 'success'
                          text: '{0}{1}'
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'success'
                          text: '{0}{1}'
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'FireTime'
                    formatter: 6
                  }
                  {
                    columnMatch: 'LastModifiedTime'
                    formatter: 6
                  }
                  {
                    columnMatch: 'OpenTime'
                    formatter: 8
                    formatOptions: {
                      palette: 'greenRed'
                    }
                  }
                ]
                filter: true
                hierarchySettings: {
                  treeType: 1
                  groupBy: [
                    'subscriptionId'
                  ]
                  expandTopLevel: true
                  finalBy: 'name'
                }
              }
            }
            name: 'query - 0'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'Alerts'
      }
      name: 'Group - Alerts'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 9
            content: {
              version: 'KqlParameterItem/1.0'
              crossComponentResources: [
                '{Workspace}'
              ]
              parameters: [
                {
                  id: '1a79bc93-b09a-4bb4-93d3-ea8c184736fa'
                  version: 'KqlParameterItem/1.0'
                  name: 'HostName'
                  type: 2
                  isRequired: true
                  multiSelect: true
                  quote: '\''
                  delimiter: ','
                  query: 'AVSSyslog \r\n| distinct HostName'
                  crossComponentResources: [
                    '{Workspace}'
                  ]
                  typeSettings: {
                    additionalResourceOptions: [
                      'value::all'
                    ]
                    showDefault: false
                  }
                  timeContext: {
                    durationMs: 0
                  }
                  timeContextFromParameter: 'TimeRange'
                  queryType: 0
                  resourceType: 'microsoft.operationalinsights/workspaces'
                  value: [
                    'value::all'
                  ]
                }
                {
                  id: 'd4044f39-295b-4158-adc7-e82afee13409'
                  version: 'KqlParameterItem/1.0'
                  name: 'AppName'
                  type: 2
                  isRequired: true
                  multiSelect: true
                  quote: '\''
                  delimiter: ','
                  query: 'AVSSyslog \r\n| distinct AppName'
                  crossComponentResources: [
                    '{Workspace}'
                  ]
                  typeSettings: {
                    additionalResourceOptions: [
                      'value::all'
                    ]
                    showDefault: false
                  }
                  timeContext: {
                    durationMs: 0
                  }
                  timeContextFromParameter: 'TimeRange'
                  queryType: 0
                  resourceType: 'microsoft.operationalinsights/workspaces'
                  value: [
                    'value::all'
                  ]
                }
                {
                  version: 'KqlParameterItem/1.0'
                  name: 'Severity'
                  type: 2
                  isRequired: true
                  multiSelect: true
                  quote: '\''
                  delimiter: ','
                  query: 'AVSSyslog \r\n| distinct Severity'
                  crossComponentResources: [
                    '{Workspace}'
                  ]
                  typeSettings: {
                    additionalResourceOptions: [
                      'value::all'
                    ]
                    showDefault: false
                  }
                  timeContext: {
                    durationMs: 0
                  }
                  timeContextFromParameter: 'TimeRange'
                  queryType: 0
                  resourceType: 'microsoft.operationalinsights/workspaces'
                  value: [
                    'value::all'
                  ]
                  id: '83f0c115-953b-42db-870c-b22344745fba'
                }
              ]
              style: 'pills'
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
            }
            name: 'parameters - 0'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'AVSSyslog \r\n| where HostName in ({HostName})\r\n| where AppName in ({AppName})\r\n| where Severity in ({Severity}) or \'*\' in ({Severity})\r\n| summarize count() by Severity'
              size: 4
              title: 'Count of records by severity'
              timeContextFromParameter: 'TimeRange'
              exportFieldName: 'Severity'
              exportParameterName: 'Sev'
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
              crossComponentResources: [
                '{Workspace}'
              ]
              visualization: 'tiles'
              tileSettings: {
                titleContent: {
                  columnMatch: 'Severity'
                  formatter: 1
                }
                leftContent: {
                  columnMatch: 'count_'
                  formatter: 12
                  formatOptions: {
                    palette: 'auto'
                  }
                  numberFormat: {
                    unit: 17
                    options: {
                      maximumSignificantDigits: 3
                      maximumFractionDigits: 2
                    }
                  }
                }
                showBorder: true
              }
            }
            name: 'query - 2'
          }
          {
            type: 1
            content: {
              json: 'Enable collection of SysLog to your Log Analytics workspace with diagnostic settings on your AVS instance.'
            }
            name: 'text - 3'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'AVSSyslog \r\n| where HostName in ({HostName})\r\n| where AppName in ({AppName})\r\n| where Severity in ({Severity}) or \'*\' in ({Severity})\r\n| project TimeGenerated, HostName, AppName, Facility, Severity, Message'
              size: 4
              timeContextFromParameter: 'TimeRange'
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
              crossComponentResources: [
                '{Workspace}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: 'Severity'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'icons'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'debug'
                          representation: 'question'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'warn'
                          representation: '2'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'err'
                          representation: '3'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'notice'
                          representation: 'Normal'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'alert'
                          representation: 'Fired'
                          text: '{0}{1}'
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: '1'
                          text: '{0}{1}'
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'Message'
                    formatter: 7
                    formatOptions: {
                      linkTarget: 'CellDetails'
                      linkIsContextBlade: true
                    }
                  }
                ]
                filter: true
              }
            }
            name: 'query - 1'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'SysLog'
      }
      name: 'group - SysLog'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 1
            content: {
              json: '### Azure Advisor recommendations for Azure VMware Solution'
            }
            name: 'text - 1'
          }
          {
            type: 9
            content: {
              version: 'KqlParameterItem/1.0'
              crossComponentResources: [
                '{Subscription}'
              ]
              parameters: [
                {
                  id: '88c663d7-da13-44da-a53f-15f8fdb1ca57'
                  version: 'KqlParameterItem/1.0'
                  name: 'Impact'
                  type: 2
                  isRequired: true
                  multiSelect: true
                  quote: '\''
                  delimiter: ','
                  query: 'AdvisorResources\r\n| where type == \'microsoft.advisor/recommendations\'\r\n| where properties.resourceMetadata.source contains "AVS" or properties.resourceMetadata.source contains "vmware"\r\n| extend imp = tostring(properties.impact)\r\n| distinct imp'
                  crossComponentResources: [
                    '{Subscription}'
                  ]
                  value: [
                    'value::all'
                  ]
                  typeSettings: {
                    additionalResourceOptions: [
                      'value::all'
                    ]
                  }
                  timeContext: {
                    durationMs: 86400000
                  }
                  queryType: 1
                  resourceType: 'microsoft.resourcegraph/resources'
                }
              ]
              style: 'pills'
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
            }
            name: 'parameters - 2'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'AdvisorResources\r\n| where type == \'microsoft.advisor/recommendations\'\r\n| where properties.resourceMetadata.source contains "AVS" or properties.resourceMetadata.source contains "vmware"\r\n| extend SD = tostring(properties.shortDescription.solution)\r\n| extend cat = tostring(properties.category)\r\n| extend imp = tostring(properties.impact)\r\n| extend LU = tostring(properties.lastUpdated)\r\n| extend IR = tostring(properties.impactedValue)\r\n| where imp in ({Impact})\r\n| project IR, resourceGroup, SD, cat, imp, LU,subscriptionId'
              size: 0
              showRefreshButton: true
              showExportToExcel: true
              queryType: 1
              resourceType: 'microsoft.resourcegraph/resources'
              crossComponentResources: [
                '{Subscription}'
              ]
              visualization: 'table'
              gridSettings: {
                formatters: [
                  {
                    columnMatch: 'IR'
                    formatter: 13
                    formatOptions: {
                      linkTarget: 'GenericDetails'
                      linkIsContextBlade: true
                      showIcon: true
                    }
                  }
                  {
                    columnMatch: 'imp'
                    formatter: 18
                    formatOptions: {
                      thresholdsOptions: 'colors'
                      thresholdsGrid: [
                        {
                          operator: '=='
                          thresholdValue: 'High'
                          representation: 'redBright'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'Medium'
                          representation: 'yellow'
                          text: '{0}{1}'
                        }
                        {
                          operator: '=='
                          thresholdValue: 'Low'
                          representation: 'blue'
                          text: '{0}{1}'
                        }
                        {
                          operator: 'Default'
                          thresholdValue: null
                          representation: 'blue'
                          text: '{0}{1}'
                        }
                      ]
                    }
                  }
                  {
                    columnMatch: 'LU'
                    formatter: 6
                  }
                ]
                filter: true
                labelSettings: [
                  {
                    columnId: 'IR'
                    label: 'Resource'
                  }
                  {
                    columnId: 'resourceGroup'
                    label: 'RG'
                  }
                  {
                    columnId: 'SD'
                    label: 'Description'
                  }
                  {
                    columnId: 'cat'
                    label: 'Category'
                  }
                  {
                    columnId: 'imp'
                    label: 'Impact'
                  }
                  {
                    columnId: 'LU'
                    label: 'Last Updated'
                  }
                  {
                    columnId: 'subscriptionId'
                    label: 'Subscription'
                  }
                ]
              }
            }
            name: 'query - 0'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'Advisor'
      }
      name: 'group - Advisor'
    }
    {
      type: 12
      content: {
        version: 'NotebookGroup/1.0'
        groupType: 'editable'
        items: [
          {
            type: 9
            content: {
              version: 'KqlParameterItem/1.0'
              crossComponentResources: [
                '{Workspace}'
              ]
              parameters: [
                {
                  id: '88593ed5-65af-436c-a72e-ea92df78cc42'
                  version: 'KqlParameterItem/1.0'
                  name: 'ShowHelpA'
                  label: 'Show Activity Help'
                  type: 10
                  isRequired: true
                  query: 'datatable(Option:string, ) [\r\n    "Yes",\r\n    "No",\r\n]'
                  crossComponentResources: [
                    '{Workspace}'
                  ]
                  typeSettings: {
                    additionalResourceOptions: []
                    showDefault: false
                  }
                  timeContext: {
                    durationMs: 1800000
                  }
                  queryType: 0
                  resourceType: 'microsoft.operationalinsights/workspaces'
                  value: 'No'
                }
              ]
              style: 'pills'
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
            }
            name: 'parameters - 1'
          }
          {
            type: 1
            content: {
              json: 'In order for this section to display activity data first ensure that  Azure activity log collection from your AVS Private Cloud to Log Analytics is enabled.\r\n\r\nThis can be done from the Activity log blade of Azure Monitor.\r\n\r\n'
            }
            conditionalVisibility: {
              parameterName: 'ShowHelpA'
              comparison: 'isEqualTo'
              value: 'Yes'
            }
            name: 'text - 2'
          }
          {
            type: 3
            content: {
              version: 'KqlItem/1.0'
              query: 'AzureActivity \r\n| where ResourceProviderValue =="MICROSOFT.AVS"\r\n| extend prop = parse_json(Properties)\r\n| evaluate bag_unpack(prop)\r\n| project TimeGenerated, message, Level, ActivityStatusValue, Caller'
              size: 0
              showAnalytics: true
              title: 'AVS Activity'
              timeContextFromParameter: 'TimeRange'
              showExportToExcel: true
              queryType: 0
              resourceType: 'microsoft.operationalinsights/workspaces'
              crossComponentResources: [
                '{Workspace}'
              ]
              visualization: 'table'
              gridSettings: {
                filter: true
                sortBy: [
                  {
                    itemKey: 'TimeGenerated'
                    sortOrder: 1
                  }
                ]
              }
              sortBy: [
                {
                  itemKey: 'TimeGenerated'
                  sortOrder: 1
                }
              ]
            }
            name: 'query - 4'
          }
        ]
      }
      conditionalVisibility: {
        parameterName: 'Tab'
        comparison: 'isEqualTo'
        value: 'Activity'
      }
      name: 'group - Activity'
    }
  ]
  fallbackResourceIds: [
    'Azure Monitor'
  ]
  '$schema': 'https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json'
}

resource workbookId_resource 'microsoft.insights/workbooks@2021-03-08' = {
  name: workbookId
  location: Location
  kind: 'shared'
  properties: {
    displayName: 'AVS-Workbook-v8'
    serializedData: string(workbookContent)
    version: '1.0'
    sourceId: 'Azure Monitor'
    category: 'workbook'
  }
  dependsOn: []
}

output workbookId string = workbookId_resource.id
