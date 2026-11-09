// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                              = "${var.product}-${var.environment}"
  location                          = var.azure_region
  resource_group_name               = var.azure_resource_group_name
  node_resource_group               = "rg.${var.product}.aks.${var.environment}"
  dns_prefix                        = "${var.product}-${var.environment}"
  kubernetes_version                = "1.35.4"
  role_based_access_control_enabled = true
  sku_tier                          = "Free"
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    service_cidr   = "10.10.0.0/16"
    dns_service_ip = "10.10.0.10"
  }

  default_node_pool {
    name           = "default"
    vm_size        = var.aks_node_pool_default.vm_size
    vnet_subnet_id = var.azure_virtual_network_subnet_id

    auto_scaling_enabled = true
    min_count            = var.aks_node_pool_default.min_count
    max_count            = var.aks_node_pool_default.max_count

    node_labels = {
      node-group-profile = "default"
    }

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.kubernetes_cluster_identity_id]
  }

  tags = {
    environment = var.environment
  }
}