# resource "azurerm_kubernetes_cluster" "example" {
#   name                = "hcs-backend-aks"
#   location            = azurerm_resource_group.aks.location
#   resource_group_name = azurerm_resource_group.aks.name
#   dns_prefix          = "hcs-backend-aks"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "hcs-demo"
#   }
# }