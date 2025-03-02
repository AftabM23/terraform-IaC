resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
 network_security_group_id = var.nsg_id
 subnet_id = var.subnet_id   
  
}
