output "express_route_circuits" {
  value = {
    for k, value in azurerm_express_route_circuit.express_route_circuits : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "express_route_circuits_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.express_route_circuit_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
  
}