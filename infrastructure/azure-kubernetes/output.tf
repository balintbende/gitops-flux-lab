output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0]
  sensitive = true
}

output "oidc_issuer_url" {
  description = "The OIDC issuer url of the cluster, used to federate workload identities."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
}
