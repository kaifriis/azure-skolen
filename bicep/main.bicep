@allowed([
  'test'
  'prod'
])
param environment string

@minLength(2)
@maxLength(36)
@description('The name of the web site.')
param webSiteName string = 'app-${uniqueString(resourceGroup().id)}'
@minLength(3)
@maxLength(20)
@description('The name of the Azure Storage account. May contain numbers and lowercase letters only!')
param storageAccountName string = 'st-azskl-images'

@description('The SKU of the App Service Plan')
param appServiceSku string = 'F1'

@description('The location in which the Azure Storage resources should be deployed.')
param location string = resourceGroup().location

var servicePlanName = 'asp-${webSiteName}'
var blobContainerName = 'ci-image-${webSiteName}'
var websiteNameWithEnvironment = '${webSiteName}-${environment}'
var storageAccountNameWithEnvironment = '${storageAccountName}${environment}'

var tags = {
  environment: environment
  project: 'Azure Workshop'
}

var skuTier = appServiceSku == 'F1' ? 'Free' : 'Basic'

module webApp 'modules/webapp.bicep' = {
  name: 'webApp'
  params: {
    location: location
    appServicePlanName: servicePlanName
    webAppName: websiteNameWithEnvironment
    skuName: appServiceSku
    skuTier: skuTier
    tags: tags
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    storageAccountName: storageAccountNameWithEnvironment
    containerName: blobContainerName
    tags: tags
  }
}

output webAppName string = webApp.outputs.webAppName
output webAppHostName string = webApp.outputs.webAppHostName
output storageAccountName string = storage.outputs.storageAccountName
output blobContainerName string = storage.outputs.blobContainerName
