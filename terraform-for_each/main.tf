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
  features {

  }
  subscription_id = ""
}


resource "azurerm_resource_group" "name" {
  for_each = { dev : "Development resource group", prod : "Production resource group" }
  name     = "rg_${each.key}"
  location = "canadacentral"
  tags = {
    which = each.value

  }
}

resource "azurerm_virtual_network" "vnet" {
   
    for_each = azurerm_resource_group.name
    name = "abvnet-${each.key}"
    resource_group_name =each.value.name
    location = each.value.location
    address_space = [ "10.0.1.0/24" ]
    tags = {
      type = "virtual networks"
      location  = each.value.location

    }
    lifecycle {
      prevent_destroy = false
      create_before_destroy = true
      ignore_changes = [ tags ]
    }
  
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
  features {

  }
  subscription_id = ""
}


resource "azurerm_resource_group" "name" {
  for_each = { dev : "Development resource group", prod : "Production resource group" }
  name     = "rg_${each.key}"
  location = "canadacentral"
  tags = {
    which = each.value

  }
}

resource "azurerm_virtual_network" "vnet" {
   
    for_each = azurerm_resource_group.name
    name = "abvnet-${each.key}"
    resource_group_name =each.value.name
    location = each.value.location
    address_space = [ "10.0.1.0/24" ]
    tags = {
      type = "virtual networks"
      location  = each.value.location

    }
    lifecycle {
      prevent_destroy = false
      create_before_destroy = true
      ignore_changes = [ tags ]
    }
  
>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}