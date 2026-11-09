output "kubernetes_cluster_identity_id" {
  description = "The id of the user-assigned identity for the AKS control plane."
  value       = azurerm_user_assigned_identity.kubernetes_cluster.id

  depends_on = [azurerm_role_assignment.kubernetes_cluster_network_contributor]
}
