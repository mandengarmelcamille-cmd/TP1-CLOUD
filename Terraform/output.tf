output "public_ip_address" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "public_fqdn" {
  description = "Nom DNS public (FQDN) de la VM"
  value       = azurerm_public_ip.main.fqdn
}
