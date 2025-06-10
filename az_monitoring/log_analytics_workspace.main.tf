resource "azurerm_log_analytics_workspace" "log_analytics_workspaces" {
  for_each = var.log_analytics_workspaces

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
  tags                = each.value.tags
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "log_analytics_workspace_onboarding" {
  for_each = var.log_analytics_workspace_onboarding

  workspace_id                 = each.value.workspace_id
  customer_managed_key_enabled = each.value.customer_managed_key_enabled
}