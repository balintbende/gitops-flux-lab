// https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "vn-${var.product}-${var.environment}"
  address_space       = [var.azure_vn_address_space]
  location            = var.azure_region
  resource_group_name = var.azure_resource_group_name
}