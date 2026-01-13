output "scheduled_query_rules_alerts" {
  value = {
    for k, value in azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_rules_alerts : k => {
      id       = value.id
      name     = value.name
    }
  }
}