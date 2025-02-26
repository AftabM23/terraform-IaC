<<<<<<< HEAD
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.6.3"
    # }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = ""
}


# resource "random_string" "random_num" {
#   length           = 16
#   special          = true
#   override_special = "/@£$"


# }

# resource "azurerm_resource_group" "RGT" {
#   name     = "rg-${random_string.random_num.result}"
#   location = "canadacentral"

# }

resource "azurerm_resource_group" "rg" {
  count    = 3
  name     = "rg-${count.index + 1}"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet" {
  count               = 3
  name                = "ABVnet-rg-${count.index + 1}"
  resource_group_name = "rg-${count.index + 1}"
  location            = "canadacentral"
  address_space       = ["10.0.0.0/16"]
  depends_on          = [azurerm_resource_group.rg]


}


resource "azurerm_subnet" "name" {
  count                = 6
  resource_group_name  = azurerm_resource_group.rg[floor(count.index / 2)].name
  virtual_network_name = azurerm_virtual_network.vnet[floor(count.index / 2)].name
  name                 = "subnet-${count.index % 2 == 0 ? 1 : 2}"
  address_prefixes     = ["10.0.${count.index % 2}.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]

=======
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.6.3"
    # }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = ""
}


# resource "random_string" "random_num" {
#   length           = 16
#   special          = true
#   override_special = "/@£$"


# }

# resource "azurerm_resource_group" "RGT" {
#   name     = "rg-${random_string.random_num.result}"
#   location = "canadacentral"

# }

resource "azurerm_resource_group" "rg" {
  count    = 3
  name     = "rg-${count.index + 1}"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet" {
  count               = 3
  name                = "ABVnet-rg-${count.index + 1}"
  resource_group_name = "rg-${count.index + 1}"
  location            = "canadacentral"
  address_space       = ["10.0.0.0/16"]
  depends_on          = [azurerm_resource_group.rg]


}


resource "azurerm_subnet" "name" {
  count                = 6
  resource_group_name  = azurerm_resource_group.rg[floor(count.index / 2)].name
  virtual_network_name = azurerm_virtual_network.vnet[floor(count.index / 2)].name
  name                 = "subnet-${count.index % 2 == 0 ? 1 : 2}"
  address_prefixes     = ["10.0.${count.index % 2}.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]

>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}