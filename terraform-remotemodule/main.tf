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
  subscription_id = "e2c54e8b-2b32-49a6-865c-d7ede69022ac"
}

module "resource-group" {
  source             = "git::https://github.com/AftabM23/terraform-IaC.git//terraform-modules/module/resource-group?ref=v1.o"
  resourcegroup_name = var.resourcegroup_name
  location           = var.location
}

module "vnet" {
    source = "git::https://github.com/AftabM23/terraform-IaC.git//terraform-modules/module/network?ref=v1.o"
  resourcegroup_name = var.resourcegroup_name
  location           = var.location
  vnet_name =var.vnet_name
  address_space= var.address_space
}