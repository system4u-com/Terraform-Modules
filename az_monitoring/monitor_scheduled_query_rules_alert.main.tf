resource "azurerm_monitor_scheduled_query_rules_alert_v2" "scheduled_query_rules_alerts" {
  for_each = var.scheduled_query_rules_alerts

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  location            = coalesce(each.value.location, each.value.resource_group.location)

  evaluation_frequency              = each.value.evaluation_frequency
  scopes                            = each.value.scopes
  severity                          = each.value.severity
  window_duration                   = each.value.window_duration
  auto_mitigation_enabled           = each.value.auto_mitigation_enabled
  workspace_alerts_storage_enabled  = each.value.workspace_alerts_storage_enabled
  description                       = each.value.description
  display_name                      = each.value.display_name
  enabled                           = each.value.enabled
  mute_actions_after_alert_duration = each.value.mute_actions_after_alert_duration
  query_time_range_override         = each.value.query_time_range_override
  skip_query_validation             = each.value.skip_query_validation
  target_resource_types             = each.value.target_resource_types
  criteria {
    query                   = each.value.criteria.query
    time_aggregation_method = each.value.criteria.time_aggregation_method
    metric_measure_column   = each.value.criteria.metric_measure_column
    operator                = each.value.criteria.operator
    threshold               = each.value.criteria.threshold
    resource_id_column      = each.value.criteria.resource_id_column

    dynamic "failing_periods" {
      for_each = coalesce(each.value.criteria.failing_periods, {})
      content {
        minimum_failing_periods_to_trigger_alert = failing_periods.value.minimum_failing_periods_to_trigger_alert
        number_of_evaluation_periods             = failing_periods.value.number_of_evaluation_periods
      }
    }

    dynamic "dimension" {
      for_each = each.value.criteria.dimension != null ? [each.value.criteria.dimension] : []
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.values
      }
    }
  }
  dynamic "action" {
    for_each = each.value.action != null ? [each.value.action] : []
    content {
      action_groups     = action.value.action_groups
      custom_properties = action.value.custom_properties
    }
  }
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  tags = each.value.tags
}
