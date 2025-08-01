# main.tf

resource "azurerm_storage_account" "shared" {
  [cite_start]name                     = "${var.prefix}nfsstore" [cite: 4]
  [cite_start]resource_group_name      = var.resource_group_name [cite: 4]
  [cite_start]location                 = var.location [cite: 4]
  [cite_start]account_tier             = "Premium" [cite: 4]
  [cite_start]account_replication_type = "LRS" [cite: 4]
  [cite_start]account_kind             = "FileStorage" [cite: 4]
  
  # ✅ FIX: This line is required to enable the NFS protocol on the account
  nfsv3_enabled            = true

  identity {
    [cite_start]type = "SystemAssigned" [cite: 4, 5]
  }

  [cite_start]tags = var.tags [cite: 4]
}

resource "azurerm_storage_share" "nfs_share" {
  [cite_start]name                 = var.file_share_name [cite: 4]
  [cite_start]storage_account_name = azurerm_storage_account.shared.name [cite: 4]
  [cite_start]quota                = var.quota_gb * 1024 [cite: 4]
  [cite_start]enabled_protocol     = "NFS" [cite: 4]
}

# ✅ FIX: Re-added the resources to create the required directories
resource "azurerm_storage_share_directory" "models" {
  name             = "models"
  storage_share_id = azurerm_storage_share.nfs_share.id
}

resource "azurerm_storage_share_directory" "inputs" {
  name             = "inputs"
  storage_share_id = azurerm_storage_share.nfs_share.id
}

resource "azurerm_storage_share_directory" "outputs" {
  name             = "outputs"
  storage_share_id = azurerm_storage_share.nfs_share.id
}