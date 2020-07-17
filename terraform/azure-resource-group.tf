resource azurerm_resource_group core {
  name = "${local.prefix}-core-rg"
  location = var.location
}

resource azurerm_resource_group consul {
  name = "${local.prefix}-consul-rg"
  location = var.location
}

resource azurerm_resource_group hcs {
  name = "${local.prefix}-hcs-rg"
  location = var.location
}

resource azurerm_resource_group frontend {
  name = "${local.prefix}-frontend-rg"
  location = var.location
}

resource azurerm_resource_group backend {
  name = "${local.prefix}-backend-rg"
  location = var.location 
}

resource azurerm_resource_group aks {
  name = "${local.prefix}-aks-rg"
  location = var.location
}