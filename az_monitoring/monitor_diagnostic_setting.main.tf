locals {
  diagnostic_settings_flattened = flatten([
    for key, value in var.diagnostic_settings : [
      for res in value.target_resource_ids : {
        key                        = "${key}-${element(split("/", res), length(split("/", res)) - 1)}"
        name                       = value.name
        target_resource_id         = res
        log_analytics_workspace_id = value.log_analytics_workspace_id
        enable_logs                = value.enable_logs
        enable_metrics             = value.enable_metrics
        log_categories             = value.log_categories
        metric_categories          = value.metric_categories
      }
    ]
  ])
}

data "azurerm_monitor_diagnostic_categories" "monitor_diagnostic_categories" {
  for_each = { for res in local.diagnostic_settings_flattened : res.key => res }

  resource_id = each.value.target_resource_id
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_settings" {
  for_each = { for res in local.diagnostic_settings_flattened : res.key => res }

  name                       = each.value.name
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = each.value.enable_logs ? (
      length(each.value.log_categories) > 0 ? each.value.log_categories : data.azurerm_monitor_diagnostic_categories.monitor_diagnostic_categories[each.key].log_category_types 
    ) : []
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.enable_metrics ? (
      length(each.value.metric_categories) > 0 ? each.value.metric_categories : data.azurerm_monitor_diagnostic_categories.monitor_diagnostic_categories[each.key].metrics 
    ) : []
    content {
      category = metric.value
    }
  }
}
