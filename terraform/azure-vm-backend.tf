resource "azurerm_network_interface" "rkbackend" {
  name                = "rkbackend-nic"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "rkbackend" {
  name                = "rkbackend"
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location
  size                = "Standard_D2_v3"
  admin_username      = "backend"
  network_interface_ids = [
    azurerm_network_interface.rkbackend.id,
  ]

  admin_ssh_key {
    username   = "backend"
    public_key = file("~/.ssh/id_rsa.pub")
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
}