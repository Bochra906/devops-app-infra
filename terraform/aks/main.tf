resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "car-damage"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "car-damage"
  sku_tier            = "Free"

  default_node_pool {
    name       = "default"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    vm_size    = "standard_ds2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
