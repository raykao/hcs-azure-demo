resource "azurerm_public_ip" "frontend" {
  name                = "frontendPIP"
  resource_group_name = azurerm_resource_group.frontend.name
  location            = azurerm_resource_group.frontend.location
  allocation_method   = "Static"
  domain_name_label   = "${local.prefix}-frontend"

  tags = {
    environment = local.prefix
  }
}

resource "azurerm_network_interface" "rkfrontend" {
  name                = "rkfrontend-nic"
  location            = azurerm_resource_group.frontend.location
  resource_group_name = azurerm_resource_group.frontend.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }
}

resource "azurerm_linux_virtual_machine" "rkfrontend" {
  name                = "rkfrontend"
  resource_group_name = azurerm_resource_group.frontend.name
  location            = azurerm_resource_group.frontend.location
  size                = "Standard_D2_v3"
  admin_username      = "frontend"
  network_interface_ids = [
    azurerm_network_interface.rkfrontend.id,
  ]

  admin_ssh_key {
    username   = "frontend"
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