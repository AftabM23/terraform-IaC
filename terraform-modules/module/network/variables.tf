variable "vnet_name" {
  type = string
  description = "name of the virtual network"
}

variable "location" {
  type = string
  description = "location of the vnet"
}

variable "resourcegroup_name" {
  type = string
  description = "resource group of the vnet"
}

variable "address_space" {
  type = list(string)
  description = "address_space of the vnet"
}
