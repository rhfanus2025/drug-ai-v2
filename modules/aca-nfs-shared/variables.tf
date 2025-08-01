# variables.tf

variable "prefix" {
  [cite_start]description = "Prefix for naming resources." [cite: 1]
  # ✅ FIX: Added the required type attribute
  type        = string
}

variable "location" {
  [cite_start]description = "Azure region" [cite: 2]
  [cite_start]type        = string [cite: 2]
}

variable "resource_group_name" {
  [cite_start]description = "Resource group" [cite: 2]
  [cite_start]type        = string [cite: 2]
}

variable "file_share_name" {
  [cite_start]description = "Azure File Share name" [cite: 2]
  [cite_start]type        = string [cite: 2]
  [cite_start]default     = "shared-data" [cite: 2]
}

variable "quota_gb" {
  [cite_start]description = "Quota in GB" [cite: 2]
  [cite_start]type        = number [cite: 2]
  [cite_start]default     = 512 [cite: 2, 3]
}

variable "tags" {
  [cite_start]description = "Tags to apply" [cite: 3]
  [cite_start]type        = map(string) [cite: 3]
  [cite_start]default     = {} [cite: 3]
}