# Envoy Gateway controller, implements the Gateway API on the cluster.
# Installs the Gateway API CRDs + controller
# https://gateway.envoyproxy.io/docs/install/install-helm/
resource "helm_release" "envoy_gateway" {
  name             = "envoy-gateway"
  repository       = "oci://docker.io/envoyproxy"
  chart            = "gateway-helm"
  version          = "1.8.1"
  namespace        = "envoy-gateway-system"
  create_namespace = true
}
