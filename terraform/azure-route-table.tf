resource azurerm_route_table "default" {
  name                          = "defaultRouteTable"
  location                      = azurerm_resource_group.core.location
  resource_group_name           = azurerm_resource_group.core.name
  disable_bgp_route_propagation = false

  route {
    name           = "defaultTraffic"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.core.ip_configuration[0].private_ip_address
  }

  tags = {
    environment = local.prefix
  }
}

resource azurerm_subnet_route_table_association "consul" {
  subnet_id = azurerm_subnet.consul.id
  route_table_id  = azurerm_route_table.default.id
}