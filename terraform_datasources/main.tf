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
  subscription_id = "e2c54e8b-2b32-49a6-865c-d7ede69022ac"
}

data "azurerm_resource_group" "rg1" {
  name = "valut-rg"

}
data "azurerm_key_vault" "keyVault" {
  name                = "abVault23"
  resource_group_name = data.azurerm_resource_group.rg1.name

}
data "azurerm_key_vault_secret" "secretKey" {
  name         = "vmPassword"
  key_vault_id = data.azurerm_key_vault.keyVault.id

}

data "azurerm_public_ip" "pip" {
  name                = "public_ip"
  resource_group_name = data.azurerm_resource_group.rg1.name

}

resource "azurerm_virtual_network" "abvn1_terra" {
  name                = "abvn1"
  resource_group_name = data.azurerm_resource_group.rg1.name
  location            = data.azurerm_resource_group.rg1.location
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "abvn1_subnet1_terra" {
  name                 = "abvn1_subnet1"
  virtual_network_name = azurerm_virtual_network.abvn1_terra.name
  resource_group_name  = data.azurerm_resource_group.rg1.name
  address_prefixes     = ["10.0.1.0/24"]


}

resource "azurerm_network_security_group" "ab_nsg1_terra1" {
  name                = "ab_nsg_subnet1"
  resource_group_name = data.azurerm_resource_group.rg1.name
  location            = data.azurerm_resource_group.rg1.location
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



resource "azurerm_network_interface" "nic_ab_terra" {
  name                = "nic_ab"
  resource_group_name = data.azurerm_resource_group.rg1.name
  location            = data.azurerm_resource_group.rg1.location
  ip_configuration {
    name                          = "ab_ipConfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.abvn1_subnet1_terra.id
    public_ip_address_id          = data.azurerm_public_ip.pip.id
  }

}


resource "azurerm_linux_virtual_machine" "vm1_terra" {
  name                  = "VM1-Linux"
  resource_group_name   = data.azurerm_resource_group.rg1.name
  location              = data.azurerm_resource_group.rg1.location
  network_interface_ids = [azurerm_network_interface.nic_ab_terra.id]
  size                  = "Standard_B1s"
  admin_username        = "Ab23"
  admin_password =  data.azurerm_key_vault_secret.secretKey.value
  
disable_password_authentication = false
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
}

output "pip" {
    value = data.azurerm_public_ip.pip.ip_address
  
}