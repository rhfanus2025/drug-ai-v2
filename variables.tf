
variable "location" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "ssh_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "admin_username" {
  type        = string
  description = "Admin username for VM login"
}

variable "ghcr_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Container Registry Personal Access Token"
}

variable "github_user" {
  type        = string
  description = "GitHub username for container image pull"
}

variable "azure_openai_api_key" {
  type        = string
  sensitive   = true
}

variable "azure_openai_base_url" {
  type        = string
}

variable "azure_openai_api_version" {
  type        = string
}

variable "azure_openai_deployment" {
  type        = string
}

variable "image_url" {
  type        = string
  description = "Container image URL for AutoGen ACA"
}

variable "langgraph_image_url" {
  type        = string
  description = "Container image URL for LangGraph ACA"
}

variable "tags" {
  type = map(string)
  default = {
    project = "drug-ai-platform"
    env     = "prod"
  }
}
