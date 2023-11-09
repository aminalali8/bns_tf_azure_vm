# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "resources-amin-bns-${var.suffix}"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "network-bns-${var.suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {
  name                = "pip-bns-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "main" {
  name                = "nic-bns-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "vm-bns-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "${var.admin_user}"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "${var.admin_user}"
    public_key = "${var.public_key}"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  provisioner "remote-exec" {
#    inline = [
#      "sudo apt update",
#      "sudo apt install -y git",
#      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
#      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
#      "yes | sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
#      "sudo apt update",
#      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose",
#      "sudo usermod -aG docker $USER",
#      "mkdir -p app",
#      "cd app",
#      "git clone https://github.com/aminalali8/demo-books.git ./",
#      "sudo docker-compose up -d"
#    ]
#    script = "init_app.sh"
    scripts = ["init_app.sh"]

    connection {
      host        = self.public_ip_address
      user        = self.admin_username
      private_key = file("${var.private_key_file_name}")
    }
  }
}