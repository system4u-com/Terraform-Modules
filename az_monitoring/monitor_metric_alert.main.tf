resource "azurerm_monitor_metric_alert" "monitor_metric_alerts" {
  for_each = var.monitor_metric_alerts

  name                     = coalesce(each.value.name, each.key)
  resource_group_name      = each.value.resource_group.name
  scopes                   = each.value.scopes
  description              = each.value.description
  enabled                  = each.value.enabled
  auto_mitigate            = each.value.auto_mitigate
  frequency                = each.value.frequency
  window_size              = each.value.window_size
  severity                 = each.value.severity
  target_resource_type     = each.value.target_resource_type
  target_resource_location = each.value.target_resource_location
  dynamic "criteria" {
    for_each = each.value.criterias
    content {
      metric_name      = criteria.value.metric_name
      metric_namespace = criteria.value.metric_namespace
      operator         = criteria.value.operator
      aggregation      = criteria.value.aggregation
      threshold        = criteria.value.threshold

      dynamic "dimension" {
        for_each = criteria.value.dimensions != null ? criteria.value.dimensions : []
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }
  dynamic "action" {
    for_each = each.value.actions
    content {
      action_group_id    = action.value.action_group_id
      webhook_properties = action.value.webhook_properties
    }
  }
  tags = each.value.tags
}
