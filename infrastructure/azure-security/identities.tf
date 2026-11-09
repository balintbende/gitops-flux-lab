// Workload identity for the kubernetes api
// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity
resource "azurerm_user_assigned_identity" "api" {
  name                = "id-${var.product}-api-${var.environment}"
  resource_group_name = var.azure_resource_group_name
  location            = var.azure_region

  tags = {
    environment = var.environment
  }
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential
resource "azurerm_federated_identity_credential" "api" {
  name                      = "aks-${var.environment}-api"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = var.kubernetes_oidc_issuer_url
  subject                   = "system:serviceaccount:${var.kubernetes_namespace_name}:api"
  user_assigned_identity_id = azurerm_user_assigned_identity.api.id
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "api_blob_data_contributor" {
  scope                = var.azure_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.api.principal_id
  principal_type       = "ServicePrincipal"
}

# Referenced by the api deployment (see charts/templates/api/deployment.yaml).
resource "kubernetes_service_account_v1" "api" {
  metadata {
    name      = "api"
    namespace = var.kubernetes_namespace_name

    annotations = {
      "azure.workload.identity/client-id" = azurerm_user_assigned_identity.api.client_id
    }
  }
}

// Control plane identity for the kubernetes cluster (load balancers, disks, subnet join)
// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity
resource "azurerm_user_assigned_identity" "kubernetes_cluster" {
  name                = "id-${var.product}-aks-${var.environment}"
  resource_group_name = var.azure_resource_group_name
  location            = var.azure_region

  tags = {
    environment = var.environment
  }
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "kubernetes_cluster_network_contributor" {
  scope                = var.azure_virtual_network_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.kubernetes_cluster.principal_id
  principal_type       = "ServicePrincipal"
}

