@description('The environment name. "dev" and "prod" are valid values.')
param environmentName string = 'dev'
param location string = 'norwayeast'

var tags = {
  environment: environmentName
  project: 'Azure Workshop'
}

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-workshop-${environmentName}'
  location: location
  tags: tags
}

output resourceGroupName string = rg.name

module storageAccount 'modules/storageAccount.bicep' = {
  scope: rg
  name: 'st-${environmentName}'
  params: {
    location: location
    tags: tags
  }
}

