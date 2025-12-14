variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default = "demo-aks-rg"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "West Europe"  
}