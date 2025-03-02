variable "resourcegroup_name" {
  type        = string
  description = "name of the resource group"

}

variable "location" {
  type        = string
  description = "location of the resource"
}

variable "vnet_name" {
  type        = string
  description = "name of the vnet"

}

variable "vnet_address_space" {
  type        = list(string)
  description = "address space of the vnet"

}
variable "subnet_name" {
  type        = string
  description = "name of the subnet"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "subnet address prefixes"
}

variable "nsg_name" {
  type        = string
  description = "nsg name"

}