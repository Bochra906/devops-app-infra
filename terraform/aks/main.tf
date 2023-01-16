data "azurerm_resource_group" "dev" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "car-damage"
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
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
