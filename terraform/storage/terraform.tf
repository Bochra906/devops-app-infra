terraform {
    required_version = "~>1.3.4"
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>3.31.0"
        }
    }
    backend "azurerm" {
    resource_group_name  = "group1"
    storage_account_name = "bochrasinda"
    container_name       = "storage"
    key                  = "storage.json"
  }
}
provider "azurerm" {
  features {}
}