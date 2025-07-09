output "monitor_metric_alerts" {
  value = {
    for k, value in azurerm_monitor_metric_alert.monitor_metric_alerts : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}