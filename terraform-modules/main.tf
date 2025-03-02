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
  source             = "./module/resource-group"
  resourcegroup_name = var.resourcegroup_name
  location           = var.location

}

module "vnet" {
  source             = "./module/network"
  vnet_name          = var.vnet_name
  location           = var.location
  resourcegroup_name = var.resourcegroup_name
  address_space      = var.vnet_address_space
}
module "subnet" {
  source             = "./module/subnet"
  subnet_name        = var.subnet_name
  resourcegroup_name = var.resourcegroup_name
  vnet_name          = var.vnet_name
  address_prefixes   = var.subnet_address_prefixes

}

module "nsg" {
  source             = "./module/nsg"
  nsg_name           = var.nsg_name
  resourcegroup_name = var.resourcegroup_name
  location           = var.location

}

module "nsg_subnet_assoc" {
  source    = "./module/nsg_association"
  nsg_id    = module.nsg.nsg-id
  subnet_id = module.subnet.subnet-id

}