resource "azurerm_monitor_action_group" "monitor_action_groups" {
  for_each = var.monitor_action_groups

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  short_name          = coalesce(each.value.short_name, each.value.name, each.key) // Use the name if short name is not specified
  enabled = each.value.enabled
  dynamic "email_receiver" {
    for_each = each.value.email_receivers
    content {
      name          = email_receiver.value.name
      email_address = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema // Default status is "Enabled"
    }
  }
  tags                = each.value.tags
}