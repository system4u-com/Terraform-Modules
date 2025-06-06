resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_settings" {
  for_each = var.custom_diagnostic_settings

  name                       = "${var.custom_diagnostic_setting_name_prefix}${each.value.name}"
  target_resource_id         = each.value.resource_id
  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = each.value.log_categories != null ? each.value.log_categories : []
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.metric_categories != null ? each.value.metric_categories : []
    content {
      category = metric.value
    }
  }
}
