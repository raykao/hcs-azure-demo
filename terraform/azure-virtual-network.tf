resource azurerm_virtual_network core {
  name                = "consul-demo-vnet"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "consul-demo"
  }
}

resource azurerm_subnet "frontend" {
    name           = "frontend-subnet"
    address_prefixes = ["10.0.1.0/24"]
    resource_group_name = azurerm_resource_group.core.name
    virtual_network_name = azurerm_virtual_network.core.name
}

resource azurerm_subnet "backend" {
    name           = "backend-subnet"
    address_prefixes = ["10.0.2.0/24"]
    resource_group_name = azurerm_resource_group.core.name
    virtual_network_name = azurerm_virtual_network.core.name
}

resource azurerm_subnet "consul" {
    name            = "consul-subnet"
    address_prefixes = ["10.0.3.0/24"]
    resource_group_name = azurerm_resource_group.core.name
    virtual_network_name = azurerm_virtual_network.core.name
}

resource azurerm_subnet "firewall" {
  name = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes  = ["10.0.4.0/26"]
}

resource azurerm_subnet "loadbalancers" {
  name = "LoadbalancerSubnet"
  resource_group_name = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes  = ["10.0.5.0/26"]
}

resource azurerm_subnet "jumpbox" {
  name = "JumpboxSubnet"
  resource_group_name = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes  = ["10.0.6.0/26"]
}

resource azurerm_subnet "aks" {
    name           = "aks-subnet"
    address_prefixes = ["10.0.128.0/17"]
    resource_group_name = azurerm_resource_group.core.name
    virtual_network_name = azurerm_virtual_network.core.name
}