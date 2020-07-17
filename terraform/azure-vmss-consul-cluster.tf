resource "azurerm_lb" "consul" {
  name                = "consul"
  location            = azurerm_resource_group.consul.location
  resource_group_name = azurerm_resource_group.consul.name
  sku = "standard"

  frontend_ip_configuration {
    name                 = "privateIP"
    subnet_id = azurerm_subnet.loadbalancers.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  name                = "BackEndAddressPool"
  resource_group_name = azurerm_resource_group.consul.name
  loadbalancer_id     = azurerm_lb.consul.id
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = azurerm_resource_group.consul.name
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.consul.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "privateIP"
}

# resource "azurerm_lb_probe" "consul" {
#   resource_group_name = azurerm_resource_group.consul.name
#   loadbalancer_id     = azurerm_lb.consul.id
#   name                = "http-probe"
#   protocol            = "Http"
#   request_path        = "/health"
#   port                = 8080
# }

resource "azurerm_virtual_machine_scale_set" "consul" {
  name                = "consul-cluster"
  location            = azurerm_resource_group.consul.location
  resource_group_name = azurerm_resource_group.consul.name

  # automatic rolling upgrade
  automatic_os_upgrade = false
  upgrade_policy_mode  = "manual"

  # rolling_upgrade_policy {
  #   max_batch_instance_percent              = 20
  #   max_unhealthy_instance_percent          = 20
  #   max_unhealthy_upgraded_instance_percent = 5
  #   pause_time_between_batches              = "PT0S"
  # }

  # # required when using rolling upgrade policy
  # health_probe_id = azurerm_lb_probe.consul.id

  sku {
    name     = "Standard_D2_v3"
    tier     = "Standard"
    capacity = 3
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = local.prefix
    admin_username       = "consul"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/consul/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  network_profile {
    name    = "consul-networkprofile"
    primary = true

    ip_configuration {
      name                                   = "ConsulIPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.consul.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }

  tags = {
    environment = local.prefix
  }
}