# ./variables.tf

# --- Global Prefix & Metadata ---
variable "prefix" {
  type        = string
  description = "Unique prefix for naming resources (e.g., 'drugai')"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group (e.g., 'rg-drug-ai-v2')"
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources (e.g., 'westus3')"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    project = "drug-ai-platform"
    env     = "prod"
  }
}

# --- VM & SSH Configuration ---
variable "admin_username" {
  type        = string
  description = "Admin username for the control VM"
}

variable "ssh_key_path" {
  type        = string
  description = "Path to your SSH public key (e.g., ~/.ssh/id_rsa.pub)"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size for the control node (e.g., Standard_D8s_v6)"
}

# --- GitHub Container Registry Access ---
variable "github_user" {
  type        = string
  description = "GitHub username for GHCR authentication"
}

variable "ghcr_pat" {
  type        = string
  description = "GitHub Personal Access Token (read:packages)"
  sensitive   = true
}

# --- Azure OpenAI (optional, for ACA) ---
variable "autogen_image_url" {
  type        = string
  default     = ""
  description = "Container image URL for AutoGen service"
}

variable "langgraph_image_url" {
  type        = string
  default     = ""
  description = "Container image URL for LangGraph service"
}

variable "azure_openai_api_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Azure OpenAI API Key"
}

variable "azure_openai_base_url" {
  type        = string
  default     = ""
  description = "Azure OpenAI base endpoint"
}

variable "azure_openai_api_version" {
  type        = string
  default     = ""
  description = "Azure OpenAI API version (e.g., '2025-01-01-preview')"
}

variable "azure_openai_deployment" {
  type        = string
  default     = ""
  description = "Deployed model name in Azure OpenAI"
}