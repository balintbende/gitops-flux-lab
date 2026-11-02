# Workload identity for the api: the pod's service account token is exchanged for an
# Azure AD token of this managed identity, so no storage account key is needed.
locals {
  api_service_account_name = "api"
}

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
  name                = "aks-${var.environment}-${local.api_service_account_name}"
  resource_group_name = var.azure_resource_group_name
  parent_id           = azurerm_user_assigned_identity.api.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.kubernetes_oidc_issuer_url
  subject             = "system:serviceaccount:${var.kubernetes_namespace_name}:${local.api_service_account_name}"
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
    name      = local.api_service_account_name
    namespace = var.kubernetes_namespace_name

    annotations = {
      "azure.workload.identity/client-id" = azurerm_user_assigned_identity.api.client_id
    }
  }
}
