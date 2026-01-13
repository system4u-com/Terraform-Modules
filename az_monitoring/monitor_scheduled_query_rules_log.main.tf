resource "azurerm_monitor_scheduled_query_rules_log" "monitor_scheduled_query_rules_logs" {
  for_each = var.monitor_scheduled_query_rules_logs

  name                     = coalesce(each.value.name, each.key)
  resource_group_name      = each.value.resource_group.name
  description              = each.value.description
  enabled                  = each.value.enabled
  location                 = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  data_source_id           = each.value.data_source_id
  authorized_resource_ids  = each.value.authorized_resource_ids
  criteria {
      metric_name      = each.value.criteria.metric_name
      dimension {
          name     = each.value.criteria.dimension.name
          operator = each.value.criteria.dimension.operator
          values   = each.value.criteria.dimension.values
        }
      }
  tags = merge(each.value.tags, {
    "hidden:link:${each.value.data_source_id}" = "Resource"
  })  
}
