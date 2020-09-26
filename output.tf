output "az_network_interface_id" {
  description = "The id of the newly created Network Interface"
  value       = azurerm_network_interface.az_network_interface.id
}

output "az_network_interface_name" {
  description = "The name of the newly created Network Interface"
  value       = var.name
}
