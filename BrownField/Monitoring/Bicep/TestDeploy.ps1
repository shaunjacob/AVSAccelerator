az deployment sub create --name LevelUp-Lab23 --location australiaeast --template-file ESLZDeploy.bicep --parameters LEVELUP-LAB23.parameters.json --no-wait


az deployment group create --resource-group SJAVSAUE-PrivateCloud --template-file AVSDiagnostics.bicep