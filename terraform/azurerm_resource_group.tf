resource azurerm_resource_group default {
  name = "default-rg"
  location = var.location
}

resource azurerm_resource_group consul {
  name = "consul-rg"
  location = var.location
}

resource azurerm_resource_group hcs {
  name = "hcs-rg"
  location = var.location
}

resource azurerm_resource_group frontend {
  name = "frontend-rg"
  location = var.location
}

resource azurerm_resource_group backend {
  name = "backend-rg"
  location = var.location 
}

resource azurerm_resource_group aks {
  name = "aks-rg"
  location = var.location
}