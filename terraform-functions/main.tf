<<<<<<< HEAD
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = ""
}
variable "resource_groups" {
  default = ["rg1", "rg2", "rg3"]
}

resource "azurerm_resource_group" "rg" {
  count    = length(var.resource_groups)
  name     = "rg-${count.index + 1}"
  location = "CanadaCentral"

}

resource "azurerm_virtual_network" "Vnet" {
  count               = length(var.resource_groups)
  name                = "ABVnet-RG${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg[count.index].name
  location            = azurerm_resource_group.rg[count.index].location
  address_space       = ["10.${floor(count.index)}.0.0/16"]
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.resource_groups) * 2
  resource_group_name  = azurerm_resource_group.rg[floor(count.index / 2)].name
  name                 = "subnet-${count.index % 2 + 1}"
  virtual_network_name = azurerm_virtual_network.Vnet[floor(count.index / 2)].name
  address_prefixes     = ["10.${floor(count.index / 2)}.${count.index % 2 == 0 ? 0 : 1}.0/24"]
  depends_on           = [azurerm_virtual_network.Vnet]
=======
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = ""
}
variable "resource_groups" {
  default = ["rg1", "rg2", "rg3"]
}

resource "azurerm_resource_group" "rg" {
  count    = length(var.resource_groups)
  name     = "rg-${count.index + 1}"
  location = "CanadaCentral"

}

resource "azurerm_virtual_network" "Vnet" {
  count               = length(var.resource_groups)
  name                = "ABVnet-RG${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg[count.index].name
  location            = azurerm_resource_group.rg[count.index].location
  address_space       = ["10.${floor(count.index)}.0.0/16"]
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.resource_groups) * 2
  resource_group_name  = azurerm_resource_group.rg[floor(count.index / 2)].name
  name                 = "subnet-${count.index % 2 + 1}"
  virtual_network_name = azurerm_virtual_network.Vnet[floor(count.index / 2)].name
  address_prefixes     = ["10.${floor(count.index / 2)}.${count.index % 2 == 0 ? 0 : 1}.0/24"]
  depends_on           = [azurerm_virtual_network.Vnet]
>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}