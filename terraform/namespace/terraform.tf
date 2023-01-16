terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.16.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "group1"
    container_name       = "namespace"
    storage_account_name = "bochrasinda"
    key                  = "namespace.json"
  }
}