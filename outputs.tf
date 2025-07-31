# Resource Group Info
output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group."
}

# Bastion Info
output "bastion_dns" {
  value       = module.bastion.bastion_dns
  description = "DNS name of the Azure Bastion host."
}

# VM Info
output "vm_id" {
  value       = module.vm_ctrl.vm_id
  description = "ID of the VM instance."
}

output "vm_nic_id" {
  value       = module.vm_ctrl.vm_nic_id
  description = "NIC ID of the VM."
}

output "vm_private_ip" {
  value       = module.vm_ctrl.private_ip
  description = "Private IP address of the VM."
}

# LangGraph ACA Info
output "langgraph_fqdn" {
  value       = module.langgraph_aca.app_url
  description = "FQDN URL of the LangGraph container app."
}

# Autogen ACA Info
output "autogen_fqdn" {
  value       = module.autogen_aca.app_url
  description = "FQDN URL of the AutoGen container app."
}

# Shared Storage Info
output "shared_storage_account_name" {
  value       = module.shared.storage_account_name
  description = "Shared Azure Files storage account name."
}

output "shared_file_share_name" {
  value       = module.shared.file_share_name
  description = "Shared file share name."
}