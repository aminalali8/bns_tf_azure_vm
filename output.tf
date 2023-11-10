output "vm_ip" {
  value = azurerm_public_ip.main.ip_address
}

output "vm_fqdn" {
  value = azurerm_public_ip.main.fqdn
}