resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  values     = ["${file("${path.module}/values/prometheus.values.yml")}"]
  chart      = "prometheus"
  namespace  = var.namespace
}

resource "helm_release" "grafana" {
  name = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart = "grafana"

}