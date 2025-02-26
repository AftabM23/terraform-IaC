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
  features {}
  subscription_id = ""
}

resource "azurerm_resource_group" "RG1T-terra" {
  name     = "RG1"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "abvn1_terra" {
  name                = "abvn1"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "abvn1_subnet1_terra" {
  name                 = "abvn1_subnet1"
  virtual_network_name = azurerm_virtual_network.abvn1_terra.name
  resource_group_name  = azurerm_resource_group.RG1T-terra.name
  address_prefixes     = ["10.0.1.0/24"]


}

resource "azurerm_network_security_group" "ab_nsg1_terra1" {
  name                = "ab_nsg_subnet1"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  security_rule {
    name                       = "allowing_SSH_inbound"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "abvn1_subnet1_nsg_subnet1_association_terra" {
  subnet_id                 = azurerm_subnet.abvn1_subnet1_terra.id
  network_security_group_id = azurerm_network_security_group.ab_nsg1_terra1.id
}

resource "azurerm_public_ip" "ab_ip1_terra" {
  name                = "ab_ip1"
  location            = azurerm_resource_group.RG1T-terra.location
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic_ab_terra" {
  name                = "nic_ab"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  ip_configuration {
    name                          = "ab_ipConfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.abvn1_subnet1_terra.id
     public_ip_address_id          = azurerm_public_ip.ab_ip1_terra.id 
  }

}


resource "azurerm_linux_virtual_machine" "vm1_terra" {
  name                  = "VM1-Linux"
  resource_group_name   = azurerm_resource_group.RG1T-terra.name
  location              = azurerm_resource_group.RG1T-terra.location
  network_interface_ids = [azurerm_network_interface.nic_ab_terra.id, ]
  size                  = "Standard_B1s"
  admin_username        = "Ab23"
  admin_ssh_key {
    username   = "Ab23"
     public_key = file("location")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

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
  features {}
  subscription_id = ""
}

resource "azurerm_resource_group" "RG1T-terra" {
  name     = "RG1"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "abvn1_terra" {
  name                = "abvn1"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "abvn1_subnet1_terra" {
  name                 = "abvn1_subnet1"
  virtual_network_name = azurerm_virtual_network.abvn1_terra.name
  resource_group_name  = azurerm_resource_group.RG1T-terra.name
  address_prefixes     = ["10.0.1.0/24"]


}

resource "azurerm_network_security_group" "ab_nsg1_terra1" {
  name                = "ab_nsg_subnet1"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  security_rule {
    name                       = "allowing_SSH_inbound"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "abvn1_subnet1_nsg_subnet1_association_terra" {
  subnet_id                 = azurerm_subnet.abvn1_subnet1_terra.id
  network_security_group_id = azurerm_network_security_group.ab_nsg1_terra1.id
}

resource "azurerm_public_ip" "ab_ip1_terra" {
  name                = "ab_ip1"
  location            = azurerm_resource_group.RG1T-terra.location
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic_ab_terra" {
  name                = "nic_ab"
  resource_group_name = azurerm_resource_group.RG1T-terra.name
  location            = azurerm_resource_group.RG1T-terra.location
  ip_configuration {
    name                          = "ab_ipConfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.abvn1_subnet1_terra.id
     public_ip_address_id          = azurerm_public_ip.ab_ip1_terra.id 
  }

}


resource "azurerm_linux_virtual_machine" "vm1_terra" {
  name                  = "VM1-Linux"
  resource_group_name   = azurerm_resource_group.RG1T-terra.name
  location              = azurerm_resource_group.RG1T-terra.location
  network_interface_ids = [azurerm_network_interface.nic_ab_terra.id, ]
  size                  = "Standard_B1s"
  admin_username        = "Ab23"
  admin_ssh_key {
    username   = "Ab23"
     public_key = file("location")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}