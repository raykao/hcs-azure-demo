output "jumpbox-pip" {
    value = azurerm_public_ip.jumpbox.ip_address
}

output "jumpbox-fqdn" {
    value = azurerm_public_ip.jumpbox.fqdn
}