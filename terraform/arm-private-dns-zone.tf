resource "azurerm_private_dns_zone" "core" {
  name                = "raykao.com"
  resource_group_name = azurerm_resource_group.core.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "core" {
  name                  = "core-dns-zone-link"
  resource_group_name   = azurerm_resource_group.core.name
  private_dns_zone_name = azurerm_private_dns_zone.core.name
  virtual_network_id    = azurerm_virtual_network.core.id
}

# resource "azurerm_private_dns_a_record" "example" {
#   name                = "consul"
#   zone_name           = azurerm_private_dns_zone.core.name
#   resource_group_name = azurerm_resource_group.core.name
#   ttl                 = 300
#   records             = [azurerm_lb.consul.frontend_ip_configuration[0].private_ip_address]
# }