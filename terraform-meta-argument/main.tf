<<<<<<< HEAD
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = ""
}

# Topic: Using for_each with Resource Groups
variable "resource_groups" {
  type = map(string)
  default = {
    "dev"  = "eastus"
    "prod" = "canadacentral"
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = "Ab_rg-${each.key}"
  location = each.value
}

# Topic: Using for_each with Virtual Networks
variable "vnets" {
  type = map(object({
    address_space = list(string)
  }))
  default = {
    "dev"  = { address_space = ["10.0.0.0/16"] }
    "prod" = { address_space = ["10.1.0.0/16"] }
  }
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = "ABVnet-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = each.value.address_space
  depends_on          = [azurerm_resource_group.rg]
}

# Topic: Using for_each with Subnets
variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    vnet_key         = string
  }))
  default = {
    "subnet1" = { address_prefixes = ["10.0.1.0/24"], vnet_key = "dev" }
    "subnet2" = { address_prefixes = ["10.1.1.0/24"], vnet_key = "prod" }
  }
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = "ABSubnet-${azurerm_virtual_network.vnet[each.value.vnet_key].name}-${each.key}"
  resource_group_name  = azurerm_resource_group.rg[each.value.vnet_key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
  depends_on           = [azurerm_virtual_network.vnet]
}

# # Topic: Using lifecycle meta-argument
resource "azurerm_storage_account" "storage" {
  for_each             = azurerm_resource_group.rg
  name                 = "ncpl23ab${lower(each.key)}"
  resource_group_name  = each.value.name
  location             = each.value.location
  account_tier         = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true # Topic: Preventing accidental deletion
  }
  depends_on = [ azurerm_resource_group.rg ]
=======
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = ""
}

# Topic: Using for_each with Resource Groups
variable "resource_groups" {
  type = map(string)
  default = {
    "dev"  = "eastus"
    "prod" = "canadacentral"
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = "Ab_rg-${each.key}"
  location = each.value
}

# Topic: Using for_each with Virtual Networks
variable "vnets" {
  type = map(object({
    address_space = list(string)
  }))
  default = {
    "dev"  = { address_space = ["10.0.0.0/16"] }
    "prod" = { address_space = ["10.1.0.0/16"] }
  }
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = "ABVnet-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = each.value.address_space
  depends_on          = [azurerm_resource_group.rg]
}

# Topic: Using for_each with Subnets
variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    vnet_key         = string
  }))
  default = {
    "subnet1" = { address_prefixes = ["10.0.1.0/24"], vnet_key = "dev" }
    "subnet2" = { address_prefixes = ["10.1.1.0/24"], vnet_key = "prod" }
  }
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = "ABSubnet-${azurerm_virtual_network.vnet[each.value.vnet_key].name}-${each.key}"
  resource_group_name  = azurerm_resource_group.rg[each.value.vnet_key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
  depends_on           = [azurerm_virtual_network.vnet]
}

# # Topic: Using lifecycle meta-argument
resource "azurerm_storage_account" "storage" {
  for_each             = azurerm_resource_group.rg
  name                 = "ncpl23ab${lower(each.key)}"
  resource_group_name  = each.value.name
  location             = each.value.location
  account_tier         = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true # Topic: Preventing accidental deletion
  }
  depends_on = [ azurerm_resource_group.rg ]
>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}