resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  
  resource_group_name = var.resourcegroup_name
  address_prefixes = var.address_prefixes
  virtual_network_name = var.vnet_name
}

output "subnet-id" {
  value = azurerm_subnet.subnet.id
  
}