// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "storage_account" {
  name                            = replace("sta-${var.product}-${var.environment}", "-", "")
  resource_group_name             = var.azure_resource_group_name
  location                        = var.azure_region
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

  tags = {
    environment = var.environment
  }
}