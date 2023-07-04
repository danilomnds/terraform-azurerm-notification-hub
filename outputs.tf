output "name" {
  value = azurerm_notification_hub_namespace.hub_namespace.name
}

output "id" {
  value = azurerm_notification_hub_namespace.hub_namespace.id
}

output "hubs" {
  description = "hubs"
  value       = [for hubs in azurerm_notification_hub.hub : hubs.id]
}