output "monitor_scheduled_query_rules_logs" {
  value = {
    for k, value in azurerm_monitor_scheduled_query_rules_log.monitor_scheduled_query_rules_logs : k => {
      id       = value.id
      name     = value.name
    }
  }
}