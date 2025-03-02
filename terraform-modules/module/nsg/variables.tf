variable "nsg_name" {
    type = string
    description = "name of the nsg"
  
}
variable "resourcegroup_name" {
  type = string
  description = "name of the resource group for the nsg"
}

variable "location" {
  type = string
  description = "location of the nsg"
}

