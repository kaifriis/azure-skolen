@description('The environment (test or prod)')
param environment string

@description('The Azure region for deployment')
param location string

// Add your resource definitions here

// Add additional resources and configurations as needed

@minLength(2)
@maxLength(36)
@description('The name of the web site.')
param webSiteName string = 'app-${uniqueString(resourceGroup().id)}'

@minLength(3)
@maxLength(20)
@description('The name of the Azure Storage account. May contain numbers and lowercase letters only!')
param storageAccountName string = 'stazsklimages'

@description('The SKU of the App Service Plan')
param appServiceSku string = 'F1'

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
    managedIdentityPrincipalId: webApp.outputs.principalId
  }
}

output webAppName string = webApp.outputs.webAppName
output webAppHostName string = webApp.outputs.webAppHostName
output storageAccountName string = storage.outputs.storageAccountName
output blobContainerName string = storage.outputs.blobContainerName
