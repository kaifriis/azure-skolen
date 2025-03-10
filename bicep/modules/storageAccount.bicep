param location string
param tags object

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stworkshop${uniqueString(resourceGroup().id)}'
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
