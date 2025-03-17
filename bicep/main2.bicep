param location string = resourceGroup().location
param appServicePlanName string = 'workshop-asp'
param webAppName string = 'workshop-webapp-${uniqueString(resourceGroup().id)}'
param storageAccountName string = 'workshopst${uniqueString(resourceGroup().id)}'
param containerName string = 'images'

module webAppModule 'modules/webapp.bicep' = {
  name: 'webAppDeploy'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    webAppName: webAppName
  }
}

module storageModule 'modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    location: location
    storageAccountName: storageAccountName
    containerName: containerName
  }
}

output webAppName string = webAppModule.outputs.webAppName
output webAppHostName string = webAppModule.outputs.webAppHostName
output storageAccountName string = storageModule.outputs.storageAccountName
output blobContainerName string = storageModule.outputs.blobContainerName
