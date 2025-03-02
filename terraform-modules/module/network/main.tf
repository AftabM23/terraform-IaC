resource "azurerm_virtual_network" "name" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resourcegroup_name
  address_space = var.address_space
}