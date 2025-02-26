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
  features {}
  subscription_id = ""
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-1"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet" {
  name                = "ABVnet-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "subnet" {
  name                 = "Subnet1"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-allow-ssh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "allow-ssh"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_public_ip" "public_ip" {
  name                = "ab_publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "NIC" {
  name                = "ab_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ab_ip_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
    public_ip_address_id          = azurerm_public_ip.public_ip.id

  }

}

resource "azurerm_linux_virtual_machine" "linuxVM" {
  name                  = "AbVM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.NIC.id]
  size                  = "Standard_B1s"
  admin_username        = "Aftab"
  admin_ssh_key {
    username   = "Aftab"
    public_key = file("")

  }
  os_disk {
    name                 = "Ab_OS_Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"

    offer   = "ubuntu-24_04-lts"
    sku     = "server"
    version = "Latest"

  }


}

resource "null_resource" "null_res" {
  connection {
    type        = "ssh"
    host        = azurerm_public_ip.public_ip.ip_address
    user        = "Aftab"
    private_key = file("")

  }
  provisioner "remote-exec" {
    inline = ["sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
    "sudo systemctl start nginx"]

  }

}

resource "null_resource" "save_vm_ipAddress" {
  provisioner "local-exec" {
    command = "echo ${azurerm_public_ip.public_ip.ip_address} is the ip_address' > #PATH"
  }
}

resource "null_resource" "file_provisioner" {
     connection {
    type        = "ssh"
    host        = azurerm_public_ip.public_ip.ip_address
    user        = "Aftab"
    private_key = file("")

  }
  provisioner "file" {
    destination = "ab/Vm_IPAddress"
    source      = ""


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
  features {}
  subscription_id = ""
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-1"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet" {
  name                = "ABVnet-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "subnet" {
  name                 = "Subnet1"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-allow-ssh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "allow-ssh"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_public_ip" "public_ip" {
  name                = "ab_publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "NIC" {
  name                = "ab_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ab_ip_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
    public_ip_address_id          = azurerm_public_ip.public_ip.id

  }

}

resource "azurerm_linux_virtual_machine" "linuxVM" {
  name                  = "AbVM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.NIC.id]
  size                  = "Standard_B1s"
  admin_username        = "Aftab"
  admin_ssh_key {
    username   = "Aftab"
    public_key = file("")

  }
  os_disk {
    name                 = "Ab_OS_Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"

    offer   = "ubuntu-24_04-lts"
    sku     = "server"
    version = "Latest"

  }


}

resource "null_resource" "null_res" {
  connection {
    type        = "ssh"
    host        = azurerm_public_ip.public_ip.ip_address
    user        = "Aftab"
    private_key = file("")

  }
  provisioner "remote-exec" {
    inline = ["sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
    "sudo systemctl start nginx"]

  }

}

resource "null_resource" "save_vm_ipAddress" {
  provisioner "local-exec" {
    command = "echo ${azurerm_public_ip.public_ip.ip_address} is the ip_address' > #PATH"
  }
}

resource "null_resource" "file_provisioner" {
     connection {
    type        = "ssh"
    host        = azurerm_public_ip.public_ip.ip_address
    user        = "Aftab"
    private_key = file("")

  }
  provisioner "file" {
    destination = "ab/Vm_IPAddress"
    source      = ""


  }

>>>>>>> 9bcbcde635067ea0fb637812eb657c6dc4bd2909
}