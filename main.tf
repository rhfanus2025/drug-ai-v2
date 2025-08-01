# ./main.tf

terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- Step 1: Resource Group ---
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# --- Step 2: Virtual Network & Subnets ---
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "${var.prefix}-vnet"
  tags                = var.tags
}

# --- Step 3: Shared NFS Storage ---
module "shared_nfs" {
  source              = "./modules/aca-nfs-shared"
  prefix              = var.prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# --- Step 4: Bastion Host ---
module "bastion" {
  source              = "./modules/bastion"
  prefix              = var.prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_name           = module.network.vnet_name
  tags                = var.tags
}

# --- Step 5: Control VM ---
module "vm_ctrl" {
  source              = "./modules/vm-ctrl"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  vm_name             = "${var.prefix}-vm-ctrl"
  vm_size             = var.vm_size
  subnet_id           = module.network.vm_subnet_id
  ssh_key_path        = var.ssh_key_path
  admin_username      = var.admin_username
  tags                = var.tags
}

# --- Optional: AutoGen ACA ---
# Uncomment to enable AutoGen deployment
/*
module "autogen_aca" {
  source                      = "./modules/aca-autogen"
  prefix                      = var.prefix
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  image_url                   = var.autogen_image_url
  github_user                 = var.github_user
  ghcr_pat                    = var.ghcr_pat
  azure_openai_api_key        = var.azure_openai_api_key
  azure_openai_base_url       = var.azure_openai_base_url
  azure_openai_api_version    = var.azure_openai_api_version
  azure_openai_deployment     = var.azure_openai_deployment
  shared_storage_account_name = module.shared_nfs.storage_account_name
  shared_storage_account_key  = module.shared_nfs.primary_access_key
  shared_share_name           = module.shared_nfs.file_share_name
  tags                        = var.tags
}
*/

# --- Optional: LangGraph ACA ---
# Uncomment after AutoGen is deployed and app_url is known
/*
module "langgraph_aca" {
  source                      = "./modules/aca-langgraph"
  prefix                      = "${var.prefix}-lg"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  image_url                   = var.langgraph_image_url
  github_user                 = var.github_user
  ghcr_pat                    = var.ghcr_pat
  autogen_api_url             = module.autogen_aca.app_url
  shared_storage_account_name = module.shared_nfs.storage_account_name
  shared_storage_account_key  = module.shared_nfs.primary_access_key
  shared_share_name           = module.shared_nfs.file_share_name
  tags                        = var.tags
}
*/