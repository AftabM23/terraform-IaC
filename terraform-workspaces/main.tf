terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "statefiles-rg"
    storage_account_name = "abstatefiles"
    container_name       = "statefilecontainer"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  features {}
  subscription_id = "e2c54e8b-2b32-49a6-865c-d7ede69022ac"
}

variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "subnet_name" {}
variable "vnet_address_space" {}
variable "subnet_address_prefixes" {}

resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
  
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location =  azurerm_resource_group.rg.location
  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.subnet_address_prefixes
  
}