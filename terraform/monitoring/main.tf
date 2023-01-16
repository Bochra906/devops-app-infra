data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "group1"
    container_name       = "car-damage"
    storage_account_name = "bochrasinda"
    key                  = "cluster.json"
  }
}





resource "helm_release" "argo" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.example.id


  }