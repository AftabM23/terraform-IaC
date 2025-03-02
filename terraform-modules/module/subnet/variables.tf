variable "subnet_name" {
  type = string
  description = "name of the subnet"
}

variable "address_prefixes" {
  type = list(string)
  description = "address prefixes of the subnet"
}

variable "resourcegroup_name" {
type = string
description = "resource group of the subnet"
  
}

variable "vnet_name" {
  type = string
  description = "name of the vnet for the subnet"
}