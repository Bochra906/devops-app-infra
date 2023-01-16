data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "group1"
    container_name       = "car-damage"
    storage_account_name = "bochrasinda"
    key                  = "cluster.json"
  }
}

data "terraform_remote_state" "storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "group1"
    storage_account_name = "bochrasinda"
    container_name       = "storage"
    key                  = "storage.json"
  }
}


resource "kubernetes_namespace" "example" {
  metadata {
    annotations = {
      name = "example-annotation"
    }
    name = "monitoring"
  }
}

module "argo_cd" {
  source = "./modules/argocd"
  providers = {
    helm = helm
  }
  namespace = kubernetes_namespace.example.id
}


module "prometheus" {
  source = "./modules/prometheus"
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
  namespace = kubernetes_namespace.example.id
}

