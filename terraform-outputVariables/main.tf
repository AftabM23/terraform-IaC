terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
}
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
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}_${var.environment[0]}"
  location = var.resource_group_location

}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}-${var.environment[0]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

output "resource_group_name" {
  description = "name of the resource group"
  value       = azurerm_resource_group.rg.name

}

output "vnet_name" {
  description = "name of the vnet"
  value       = azurerm_virtual_network.vnet.name

}

output "rg_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.rg.id
}
output "vnet_id" {
  description = "vnet id"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_addressSpace" {
  description = "vent address space"
  value       = azurerm_virtual_network.vnet.address_space
}