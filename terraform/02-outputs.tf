output "jumpbox-pip" {
    value = azurerm_public_ip.jumpbox.ip_address
}

output "jumpbox-fqdn" {
    value = azurerm_public_ip.jumpbox.fqdn
}

output "frontend-pip" {
    value = azurerm_public_ip.frontend.ip_address
}

output "frontend-fqdn" {
    value = azurerm_public_ip.frontend.fqdn
}