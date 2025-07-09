resource "azurerm_monitor_metric_alert" "monitor_metric_alerts" {
  for_each = var.monitor_metric_alerts

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  scopes = each.value.scopes
  description         = each.value.description
  dynamic "criteria" {
    for_each = each.value.criterias
    content {
      metric_name      = criteria.value.metric_name
      metric_namespace = criteria.value.metric_namespace
      operator         = criteria.value.operator
      aggregation      = criteria.value.aggregation
      threshold        = criteria.value.threshold

      dynamic "dimension" {
        for_each = coalesce(criteria.value.dimensions, [])
        content {
          name     = dimensions.value.name
          operator = dimensions.value.operator
          values   = dimensions.value.values
        }
      }
    }
  }
  tags                = each.value.tags
}