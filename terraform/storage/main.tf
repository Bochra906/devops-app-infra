
data "terraform_remote_state" "aks" {
  backend = "azurerm"
  config = {
    resource_group_name  = "group1"
    storage_account_name = "bochrasinda"
    container_name       = "car-damage"
    key                  = "cluster.json"
  }
}
resource "azurerm_storage_account" "example" {
  name                     = "storageblob"
  resource_group_name      = data.terraform_remote_state.aks.outputs.resource_group_name
  location                 = data.terraform_remote_state.aks.outputs.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "container"
}

/*
resource "azurerm_storage_blob" "example" {
 name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
*/