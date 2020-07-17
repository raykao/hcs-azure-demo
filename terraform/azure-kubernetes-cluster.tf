resource azurerm_kubernetes_cluster aks {
  name                = "${local.prefix}-backend-aks"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${local.prefix}-backend-aks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  network_profile {
      network_plugin = "azure"
      network_policy = "calico"
      service_cidr = "10.0.4.0/24"
      dns_service_ip = "10.0.4.10"
      docker_bridge_cidr = "172.17.0.1/16"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "hcs-demo"
  }
}