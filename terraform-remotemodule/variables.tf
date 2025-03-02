variable "resourcegroup_name" {
  type        = string
  description = "name of the resource group"


}
variable "location" {
  type        = string
  description = "location of the resource group"

}
variable "vnet_name" {
    type = string
    description = "name of the vnet"
  
}

variable "address_space" {
    type = list(string)
    description = "address space of the vnet"
  
}