// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "vn_subnet" {
  name                 = "sn-${var.product}-${var.environment}"
  resource_group_name  = var.azure_resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.azure_vn_subnet_prefix]
} 