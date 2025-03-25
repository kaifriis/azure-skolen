param location string
param appServicePlanName string
param webAppName string
param skuName string
param skuTier string
param tags object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  kind: 'app'
  sku: {
    name: skuName
    tier: skuTier
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output webAppName string = webApp.name
output webAppHostName string = webApp.properties.defaultHostName
output principalId string = webApp.identity.principalId
