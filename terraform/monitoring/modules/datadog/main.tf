resource "helm_release" "datadog" {
  name = "datadog"
  chart = "datadog"
  repository = "https://helm.datadoghq.com"

  set {
    name = "datadog.apiKey"
    value = "bochrasinda"
    type = "string"
  }
  values = ["${file("${path.module}/values/datadog.values.yaml")}"]
}