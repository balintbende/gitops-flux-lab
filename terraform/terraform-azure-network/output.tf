output "azure_virtual_network_subnet_id" {
  description = "The id of the subnet in the virtual network."
  value       = azurerm_subnet.vn_subnet.id
}