resource azurerm_virtual_network default {
  name                = "consul-demo-vnet"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "consul-demo"
  }
}

resource azurerm_subnet "frontend" {
    name           = "frontend-subnet"
    address_prefix = "10.0.1.0/24"
}

resource azurerm_subnet "backend" {
    name           = "backend-subnet"
    address_prefix = "10.0.2.0/24"
}

resource azurerm_subnet "consul" {
    name            = "consul-subnet"
    address_prefix = "10.0.3.0/24"
}

resource azurerm_subnet "aks" {
    name           = "aks-subnet"
    address_prefix = "10.0.128.0/17"
}
