resource azurerm_public_ip "firewall-primary" {
  name                = "firewall-primary-pip"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = local.prefix
}

resource azurerm_firewall "core" {
  name                = "${local.prefix}-core-fw"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                 = "primary"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall-primary.id
  }
}