@description('The environment name. "dev" and "prod" are valid values.')
param environmentName string = 'dev'
param location string = 'norwayeast'

var tags = {
  environment: environmentName
  project: 'Azure Workshop'
}

targetScope = 'resourceGroup'

module storageAccount 'modules/storageAccount.bicep' = {
  name: 'st${environmentName}'
  params: {
    location: location
    tags: tags
  }
}
