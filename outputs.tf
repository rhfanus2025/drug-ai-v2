# ./outputs.tf

output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.main.name
}

# --- Bastion Info ---
output "bastion_dns_name" {
  description = "The DNS name of the Azure Bastion host for secure VM access."
  value       = module.bastion.bastion_dns
}

# --- VM Info ---
output "vm_ctrl_id" {
  description = "The resource ID of the control VM."
  value       = module.vm_ctrl.vm_id
}

output "vm_ctrl_private_ip" {
  description = "The private IP address of the control VM."
  value       = module.vm_ctrl.private_ip
}

# --- Shared Storage Info ---
output "shared_storage_account_name" {
  description = "The name of the shared NFS storage account."
  value       = module.shared_nfs.storage_account_name
}

output "shared_storage_primary_access_key" {
  description = "Primary access key for the shared storage account."
  value       = module.shared_nfs.primary_access_key
  sensitive   = true
}

# --- Service Endpoints (Temporarily Disabled) ---
/*
output "autogen_service_url" {
  description = "The public FQDN (URL) of the AutoGen service."
  value       = module.autogen_aca.app_url
}

output "langgraph_service_url" {
  description = "The public FQDN (URL) of the LangGraph orchestration service."
  value       = module.langgraph_aca.app_url
}
*/