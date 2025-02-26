resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}_${var.environment[0]}"
  location = var.resource_group_location

}