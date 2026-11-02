output "azure_storage_account_id" {
  description = "The id of the storage account."
  value       = azurerm_storage_account.storage_account.id
}