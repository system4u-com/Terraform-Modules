locals {
  diagnostic_settings_flattened = flatten([
    for key, value in var.diagnostic_settings : [
      for res in value.target_resource_ids : {
        key                        = "${key}-${element(split("/", res), length(res))}"
        name                       = value.name
        target_resource_id         = res
        log_analytics_workspace_id = value.log_analytics_workspace_id
        disable_logs               = value.disable_logs
        disable_metrics            = value.disable_metrics
        log_categories             = value.log_categories
        metric_categories          = value.metric_categories
      }
    ]
  ])
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_settings" {
  for_each = { for res in local.diagnostic_settings_flattened : res.key => res }

  name                       = "${var.custom_diagnostic_setting_name_prefix}${each.value.name}"
  target_resource_id         = each.value.target_resource_id
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
