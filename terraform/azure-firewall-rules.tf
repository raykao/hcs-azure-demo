resource azurerm_firewall_application_rule_collection "updates" {
  name                = "updateInfrastructure"
  azure_firewall_name = azurerm_firewall.core.name
  resource_group_name = azurerm_resource_group.core.name
  priority            = 300
  action              = "Allow"

  rule {
    name = "updateInfraRules"

    source_addresses = concat([],azurerm_virtual_network.core.address_space)

    target_fqdns = [
      "azure.archive.ubuntu.com",
      "security.ubuntu.com",
      "launchpad.net",
      "ppa.launchpad.net",
      "keyserver.ubuntu.com",
      "*.hashicorp.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "ntp" {
  name                = "ntp"
  azure_firewall_name = azurerm_firewall.core.name
  resource_group_name = azurerm_resource_group.core.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "ntp"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "123",
    ]

    destination_addresses = [
      "91.189.94.4",
      "91.189.89.198",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}