# outputs.tf

output "storage_account_name" {
  [cite_start]value       = azurerm_storage_account.shared.name [cite: 432]
  [cite_start]description = "Storage account name" [cite: 432]
}

output "file_share_name" {
  [cite_start]value       = azurerm_storage_share.nfs_share.name [cite: 432]
  [cite_start]description = "Share name" [cite: 432]
}

output "storage_account_id" {
  [cite_start]value       = azurerm_storage_account.shared.id [cite: 432]
  [cite_start]description = "Storage account resource ID" [cite: 432]
}

# ✅ FIX: Added the primary_access_key output, which is required by the ACA modules
output "primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.shared.primary_access_key
  sensitive   = true
}