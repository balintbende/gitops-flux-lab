locals {
  node_pools = {
    # High node pool, demonstration only, not provisioned.
    # Uncomment to add a dedicated high-performance node pool for workload isolation
    # (e.g. compute-heavy jobs scheduled via node selectors/taints).
    # high = {
    #   name      = "high"
    #   vm_size   = var.aks_node_pool_high.vm_size
    #   min_count = var.aks_node_pool_high.min_count
    #   max_count = var.aks_node_pool_high.max_count
    #   node_labels = {
    #     node-group-profile = "high"
    #   }
    # }
  }
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each              = local.node_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vm_size               = each.value.vm_size
  vnet_subnet_id        = var.azure_virtual_network_subnet_id

  auto_scaling_enabled = true
  min_count            = each.value.min_count
  max_count            = each.value.max_count

  node_labels = each.value.node_labels

  tags = {
    environment = var.environment
  }
}