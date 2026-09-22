resource "helm_release" "prometheus" {
  name             = "kube-prometheus-stack-${var.environment}"
  repository       = "oci://ghcr.io/prometheus-community/charts/"
  chart            = "kube-prometheus-stack"
  version          = "87.17.0"
  namespace        = "monitoring-${var.environment}"
  create_namespace = true
  values = [
    templatefile("${path.module}/prometheus.yaml", {
      service_account = "prometheus-${var.environment}"
    })
  ]
}
