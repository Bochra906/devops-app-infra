terraform {
  required_version = "~>1.3.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.31.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "group1"
    container_name       = "car-damage"
    storage_account_name = "bochrasinda"
    key                  = "cluster.json"
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}