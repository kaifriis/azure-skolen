param location string
param storageAccountName string
param containerName string
param tags object = {}
param managedIdentityPrincipalId string // Rename from webAppPrincipalId

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storageAccount
  name: 'default'
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: blobServices
  name: containerName
  properties: {
    publicAccess: 'None'
  }
}

module roleAssignment 'role-assignment.bicep' = {
  name: 'blob-role-assignment'
  params: {
    principalId: managedIdentityPrincipalId
    roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // Storage Blob Data Contributor
    storageAccountName: storageAccount.name
    principalType: 'SystemAssignedIdentity'
  }
}

output storageAccountName string = storageAccount.name
output blobContainerName string = containerName
