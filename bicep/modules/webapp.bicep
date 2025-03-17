param location string
param appServicePlanName string
param webAppName string
param skuName string
param skuTier string
param tags object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  kind: 'app'
  sku: {
    name: skuName
    tier: skuTier
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output webAppName string = webApp.name
output webAppHostName string = webApp.properties.defaultHostName

// resource webApp 'Microsoft.Web/sites@2022-09-01' = {
//   name: websiteNameWithEnvironment
//   location: location
//   tags: tags
//   kind: 'app'
//   properties: {
//     serverFarmId: appServicePlan.id
//     httpsOnly: true
//     siteConfig: {
//       minTlsVersion: '1.2'
//       appSettings: [
//         {
//           name: 'AzureStorageConfig:ImageContainer'
//           value: blobContainerName
//         }
//         {
//           name: 'AzureStorageConfig:ConnectionString'
//           value: storageAccount.listKeys().keys[0].value
//         }
//       ]
//     }
//   }
// }
