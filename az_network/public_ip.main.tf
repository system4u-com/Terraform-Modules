resource "azurerm_public_ip" "public_ips" {
  for_each = var.public_ips

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  sku                 = each.value.sku
  allocation_method   = each.value.allocation_method
  domain_name_label   = each.value.domain_name_label
  tags                = each.value.tags
}

resource "azurerm_monitor_diagnostic_setting" "public_ips_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
      { for k, v in var.public_ips : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
      { for k, v in var.public_ips : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_public_ip.public_ips[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.log_category
    category_group = (
      each.value.monitoring.log_category == null || each.value.monitoring.log_category == "" ?
      coalesce(each.value.monitoring.log_category_group, "audit") :
      null
    )
  }

  metric {
    category = coalesce(each.value.monitoring.metrics, "AllMetrics")
    enabled = each.value.monitoring.metrics_enabled
  }
}