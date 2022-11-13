az deployment sub create --name DianosticTest1 --location australiaeast --template-file Diagnostics.bicep
az deployment sub create --name Mon1 --location australiaeast --template-file eslzdeploy.bicep


az deployment group create --resource-group SJAVSAUE-PrivateCloud --template-file AVSDiagnostics.bicep
az deployment group create --resource-group SJAVSAUE-PrivateCloud --template-file Workspace.bicep
az deployment group create --resource-group SJAVSAUE-PrivateCloud --template-file EventHub.bicep
az deployment sub create --template-file ActivityLogDiagnostics.bicep --location australiaeast