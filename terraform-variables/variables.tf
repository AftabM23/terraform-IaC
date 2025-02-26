variable "environment" {
  description = "Environment name"
  type        = list(string)
  default     = ["prod", "dev"]

}

variable "resource_group_name" {
  default     = "rg"
  type        = string
  description = "name of the resource group"

}

variable "resource_group_location" {
  description = "location of the resource group"
  type        = string
  default     = "canadacentral"

}

variable "virtual_network_name" {
  description = "name of the virtual network"
  default     = "AbVnet"

}