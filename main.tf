resource "azurerm_notification_hub_namespace" "hub_namespace" {
  name                = var.namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  namespace_type      = var.namespace_type
  sku_name            = var.sku_name
  enabled             = var.enabled
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}

resource "azurerm_notification_hub" "hub" {
  depends_on = [
    azurerm_notification_hub_namespace.hub_namespace
  ]
  for_each            = var.hubs_parameters != null ? { for k, v in toset(var.hubs_parameters) : k => v } : []
  name                = each.value.name
  namespace_name      = azurerm_notification_hub_namespace.hub_namespace.name
  resource_group_name = var.resource_group_name
  location            = var.location
  dynamic "apns_credential" {
    for_each = each.value.apns_credential
    content {
      application_mode = each.value.apns_credential.application_mode
      bundle_id        = each.value.apns_credential.bundle_id
      key_id           = each.value.apns_credential.key_id
      team_id          = each.value.apns_credential.team_id
      token            = each.value.apns_credential.token
    }
  }
  dynamic "gcm_credential" {
    for_each = each.value.gcm_credential
    content {
      api_key = each.value.gcm_credential.api_key
    }
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"], apns_credential, gcm_credential
    ]
  }
}

resource "azurerm_role_assignment" "hub_namespace" {
  depends_on = [
    azurerm_notification_hub_namespace.hub_namespace
  ]
  for_each = {
    for k, v in toset(var.azure_ad_groups) : k => v
  }
  scope                = azurerm_notification_hub_namespace.hub_namespace.id
  role_definition_name = "Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "hub" {
  depends_on = [
    azurerm_notification_hub_namespace.hub_namespace
  ]
  for_each = {
    for k, v in toset(var.azure_ad_groups) : k => v
    if var.hubs_parameters != null
  }
  scope                = azurerm_storage_account.sta.id
  role_definition_name = "Notification Hub Custom"
  principal_id         = each.value
}